## Script de implantação do OSConfig - Créditos Gabriel Luiz - www.gabrielluiz.com


## 1. Instalar

<#

Antes de aplicar uma linha de base de segurança pela primeira vez, você precisa instalar o módulo OSConfig por meio de uma janela elevada do PowerShell.

#>


#  Execute o seguinte comando para instalar o módulo OSConfig:


Install-Module -Name Microsoft.OSConfig -Scope AllUsers -Repository PSGallery -Force


# Para verificar se o módulo OSConfig está instalado, execute o seguinte comando:


Get-Module -ListAvailable -Name Microsoft.OSConfig



## 2. Configurar


<#

Aplique as linhas de base de segurança apropriadas com base na função Windows Server do seu dispositivo:

. DC (Controlador de domínio)
. Servidor membro (Ingressado no domínio)
. Servidor membro do grupo de trabalho (Não ingressado no domínio)
. Núcleo seguro (Secured-core)
. Microsoft Defender Antivirus

Para aplicar uma linha de base, verificar se a linha de base foi aplicada, remover uma linha de base ou exibir informações detalhadas de conformidade para OSConfig no PowerShell, use os comandos a seguir.

#>


# Para aplicar a linha de base para um dispositivo ingressado no domínio, execute o seguinte comando:


Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer -Default



# Para aplicar a linha de base para um dispositivo que está em um grupo de trabalho, execute o seguinte comando:


Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember -Default


# Para aplicar a linha de base para um dispositivo configurado como DC, execute o seguinte comando:


Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController -Default


# Para aplicar a linha de base de Núcleo seguro (Secured-core) a um dispositivo, execute o seguinte comando:


Set-OSConfigDesiredConfiguration -Scenario SecuredCore -Default


# Para aplicar a linha de base do Microsoft Defender Antivírus a um dispositivo, execute o seguinte comando:


Set-OSConfigDesiredConfiguration -Scenario Defender/Antivirus -Default


<#

Depois de concluir a configuração da linha de base de segurança, você pode modificar as configurações de segurança enquanto mantém o controle de desvios. 

A personalização dos valores de segurança permite mais controle das políticas de segurança da sua organização, dependendo das necessidades específicas do seu ambiente.

#>


# Para editar o valor padrão de AuditDetailedFileShare de 2 para 3 do seu servidor membro, execute o seguinte comando:


Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer -Setting AuditDetailedFileShare -Value 3


# Para verificar se o novo valor foi aplicado, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer -Setting AuditDetailedFileShare




## 3. Verificar


# Para verificar se a linha de base de um dispositivo ingressado no domínio foi aplicada corretamente, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer


# Para verificar se a linha de base de um dispositivo que está em um grupo de trabalho foi aplicada corretamente, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember


# Para verificar se a linha de base de um dispositivo configurado como DC foi aplicada corretamente, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController


# Para verificar se a linha de base de Núcleo seguro (Secured-core) de um dispositivo foi aplicada corretamente, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecuredCore


# Para verificar se a linha de base do Microsoft Defender Antivírus para um dispositivo foi aplicada corretamente, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario Defender/Antivirus




## 4. Remover


# Para remover a linha de base de um dispositivo ingressado no domínio, execute o seguinte comando:


Remove-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer


# Para remover a linha de base de um dispositivo que está em um grupo de trabalho, execute o seguinte comando:


Remove-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember


# Para remover a linha de base de um dispositivo configurado como DC, execute o seguinte comando:


Remove-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController


# Para remover a linha de base de Núcleo seguro (Secured-core) de um dispositivo, execute o seguinte comando:


Remove-OSConfigDesiredConfiguration -Scenario SecuredCore


# Para remover a linha de base do Microsoft Defender Antivírus para um dispositivo, execute o seguinte comando:


Remove-OSConfigDesiredConfiguration -Scenario Defender/Antivirus



## 5. Verificar conformidade


<#

Para obter os detalhes de configuração desejados para o cenário especificado, use os comandos a seguir.

A saída aparece em um formato de tabela que inclui o nome do item de configuração, seu status de conformidade e o motivo da não conformidade.

Você também pode modificar a frequência na qual o OSConfig verifica a conformidade (controle de desvio) definindo um intervalo de atualização personalizado.

#>



# Para verificar os detalhes de conformidade de um dispositivo ingressado no domínio, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap



# Para verificar os detalhes de conformidade de um dispositivo de grupo de trabalho, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/WorkgroupMember | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap



# Para verificar os detalhes de conformidade da linha de base do DC, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap



# Para verificar os detalhes de conformidade da linha de base de Núcleo seguro (Secured-core), execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario SecuredCore | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap



# Para verificar os detalhes de conformidade da linha de base do Microsoft Defender Antivírus, execute o seguinte comando:


Get-OSConfigDesiredConfiguration -Scenario Defender/Antivirus | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap



## 6. Ajustes de configuração


# Para ajustar o intervalo de atualização de conformidade em minutos, execute o seguinte comando:


Set-OSConfigDriftControl 45


<#

Referência:

https://learn.microsoft.com/en-us/windows-server/security/osconfig/osconfig-how-to-configure-security-baselines?WT.mc_id=AZ-MVP-5003815

#>