Return-Path: <linux-spi+bounces-11374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04EC72F70
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1B67A2B5E2
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F63112AD;
	Thu, 20 Nov 2025 08:50:43 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9848310782;
	Thu, 20 Nov 2025 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628643; cv=none; b=jj0/fqKnY52Xl/DKbuo67/kRVOjIfHq/D4xX06zmqGGPaAszAZ3A681uWevdMUyBwNDlWbB6906ZPjr/vUSOaPUQw8cZg3sXNqYHyeYlq2wbR0ZhIkYrfLLdJFWIpDMwBoYICVYlGW51VOtP3L6TCcxxHZOfv8M8BZaQmxGrrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628643; c=relaxed/simple;
	bh=YpqX3lg6SVoUG7k2oQcigsO6X1to9UJN1mMwpem+Ocs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4qVG12nrBTokySk0QPa5SkvWZ78lTlcSWgwR/L/SM8sg7WyQrZI/6Awm40VkPjHSrS5bFAn/ZZ6r4EXTMyaP0eMzWXocBuVSCteCqlTFtqCMhRVXMUTvg2HJYdEKGKuQxyRUOSW9FW8cdnj98YXKhG+5mBl7A2LwG/n3mxJwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4dBsK64p43z9sTh;
	Thu, 20 Nov 2025 09:41:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kGCgBO48RIIZ; Thu, 20 Nov 2025 09:41:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4dBsK63ZVXz9sTX;
	Thu, 20 Nov 2025 09:41:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 662058B76D;
	Thu, 20 Nov 2025 09:41:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id m4DBEhXyjKTc; Thu, 20 Nov 2025 09:41:46 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 016F98B763;
	Thu, 20 Nov 2025 09:41:45 +0100 (CET)
Message-ID: <8e969a9f-4dc5-4d1e-879b-8092d43c1c38@csgroup.eu>
Date: Thu, 20 Nov 2025 09:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: fsl-cpm: Check length parity before switching to 16
 bit mode
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "florent.trinh-thai@cs-soprasteria.com"
 <florent.trinh-thai@cs-soprasteria.com>
References: <07d1ea39a0e9b56846395d79d489a5153206ff5c.1762714267.git.christophe.leroy@csgroup.eu>
 <9ff09fa3b2d8efab15d220c88d8bef4cb1cc76b3.camel@siemens.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <9ff09fa3b2d8efab15d220c88d8bef4cb1cc76b3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/11/2025 à 14:07, Sverdlin, Alexander a écrit :
> Hi Christophe,
> 
> just a couple of nitpicks below:
> 
> On Sun, 2025-11-09 at 19:55 +0100, Christophe Leroy wrote:
>> Commit fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers
>> with even size") failed to checkout that the size is really even before
>                               ^^^^^^^^
> check/verify/"make sure"?

make sure

> 
>> switching to 16 bit mode. Until recently the problem went unnoticed
>> because kernfs uses a pre-allocated bounce buffer of size PAGE_SIZE for
>> reading eeprom.
>            ^^^^^^
> EEPROM?

ack

> 
>> But commit 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
>> introduced an additional dynamically allocated bounce buffer whose size
>> is exactly the size of the transfer, leading to a buffer overrun in
>> the fsl-cpm driver when that size is odd.
>>
>> Add the missing length parity verification and remain in 8 bit mode
>> when the length is not even.
>>
>> Fixes: fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers with even size")
> 
> Missing Cc: stable@?

Nowadays Fixes: tag seems to be enough to get a fix automagically 
applied to stable branches, but I added it anyway.

> 
>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F638496dd-ec60-4e53-bad7-eb657f67d580%40csgroup.eu%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C5ac2e78d2c44433141df08de205a1e5a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638983768580305289%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=juGQhU%2F%2Fp52t9hPZ5PA0Ka8Ng3ITKNoF%2Bf1%2FP93IkOw%3D&reserved=0
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   drivers/spi/spi-fsl-spi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
>> index 2f2082652a1a2..e845baa56cc66 100644
>> --- a/drivers/spi/spi-fsl-spi.c
>> +++ b/drivers/spi/spi-fsl-spi.c
>> @@ -335,7 +335,7 @@ static int fsl_spi_prepare_message(struct spi_controller *ctlr,
>>   			if (t->bits_per_word == 16 || t->bits_per_word == 32)
>>   				t->bits_per_word = 8; /* pretend its 8 bits */
>>   			if (t->bits_per_word == 8 && t->len >= 256 &&
>> -			    (mpc8xxx_spi->flags & SPI_CPM1))
>> +			    ((t->len & 1) == 0) && (mpc8xxx_spi->flags & SPI_CPM1))
> 
> could be written as "!(t->len & 1) && "...

Done.

> 
>>   				t->bits_per_word = 16;
>>   		}
>>   	}
> 
> You can add my RB tag into your v2.
> 

Thanks
Christophe

