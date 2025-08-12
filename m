Return-Path: <linux-spi+bounces-9372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F7B2257B
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2867F622623
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F42ECD37;
	Tue, 12 Aug 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhT0sJ9+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C022B590;
	Tue, 12 Aug 2025 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996810; cv=none; b=HncIVtuvLO+envxm1f8jv7FsFo9eZfh9n22lLNVVawNIftzIvQQ1S3JbRCw9wOmj9/1PxfJgp1cVgWimfo8TTT5RDCjzVuO5qgrd/OC0Ly4efz4e5Pvn53h73m+ckJdbs3zQL7AApir9aIZhvLcdSQOZo4aHL5ZdrUYeuAuHFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996810; c=relaxed/simple;
	bh=SyT0BrOxeb8vhfCzk+ajKkLCcd5H0ocIxJvW5ovJkrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNjGYIg35ApWqqT5iIrdZmfDfjSMvaNWSL/qzAc6/Q6oRwos0IRC1rCSfM+0RHXtzaKfgQQeM58jh9Gqn6zyN0i91ubV/A/3/CAX4brgVv1OcGIyW9mDv6Ly5D+Ph8mqfm2ZvCf13m+5eWBX6V2wqpDdMUYsIKUQHkmPWULlz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhT0sJ9+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so5397497f8f.1;
        Tue, 12 Aug 2025 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754996807; x=1755601607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4LYi0dRz3wz8Z6NYKWbJ5ci0Q9fM0Vpn15hTfKF8nE=;
        b=mhT0sJ9+GL1Uz9OUbCxYxMqjmbLWM8E9VhSpYKoRhi5bWPmNst69AsZVicbS8DA5Ll
         CBZ5P2C81zO3t2F/EUzaW/QwbDOEMXOl8V9grwlzM3DTX8iqBvgpTOrZLIaceR6+iE/G
         N7KGjTwX6F5zOn12t9WKnEfzmA2Mm3s2Q86DkeWizI4H+xTFi+LTWYyh8h2/FT+GfUK1
         2p7m+8wkR3UA2v1arVGVwrTDMcObMgdTP7qAMt9sJVr8ls8RpPHQSGtflCsI0BiRoNdr
         lCrIl2dAY7ad4uC8FedNRuOht3CBE1HTqejgkip1vyast8hqkpUvWEwrWNQJmG7PTmMP
         dN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754996807; x=1755601607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4LYi0dRz3wz8Z6NYKWbJ5ci0Q9fM0Vpn15hTfKF8nE=;
        b=LwU9wopRKNo/REa1zKZc+PKe9HJ6wg4aQj67o93aGCpCSIDVoeTklXoigFvF/iEn0l
         xX3dbk+is5nv+duPX7E9sFM1oytMDAkOUlMaFekMD9EEirfW9Ew5vqgeYTPtG3FF57qq
         YoqfETehZFOSUaY87Fd+qkTQSb7HuLFq5z8K1Yndp51gmWj5zhGoSWTx92RUMEwcilAg
         5GqsYTKcuh+eCG6P7rgmMEKuyVMVZHP8nP7Aw5Sjn7tERyEA9/Nsa3pzlSesvM3+MpOB
         4cN0MvzCiEOVfR/j9FKznoN8jpUaal2so4HIif4qv1fZ04IRkLowjYR5CQW6UyioVA/E
         t56A==
X-Forwarded-Encrypted: i=1; AJvYcCUejHaJ6/Fhhlrcwc+JKov+V7rt0buautuxz0rCqFZpwvCGMQOyu/2YFsHgzhdP052rzSuk17cGIlitqmfT@vger.kernel.org, AJvYcCVJj2CJvApVPLi9FGK845nJ4p6GbFQwS7i0eyE0hID64wAjxo9HlLoRjrIzSrYqmXQSwSvSDymrzsIl@vger.kernel.org, AJvYcCW4kXiG9mP412JwX2ZUogo2gypjYJErKVRXE2n8VTBWATBONGQpGGgIJ29yzYnP6YpBGE88ldlgC9hINmAo@vger.kernel.org
X-Gm-Message-State: AOJu0YyscKsJe6tbVhcjP6HbAwdxdu/45tXRZW+fOACL5ltPM++ydoyJ
	EhyMMQMZrMC/LfEpUr4aVU8VaEK3SDl+spHlzL96Jf0UWU1PyZDQQe/8
X-Gm-Gg: ASbGncsCFbVG2eC2g8reuADL9FO4pMoG7EGAbZZpQ8cFEBK9gnXdIxrq1neTCzx7BMy
	dNP3Lix0hsqpAcizzfwYxcttT4HCAA+V6wMMiHStySW1C9nfNPuRrKv12XLoffb1k83HLSMkt78
	LSwWnT9NQpITm/FRPSlNcw+G4gRRUQQPZpM1xtR4JRwP2DS8fgj6xqXM/AyLfFonMpr10kQvVYz
	eJrKH2MwCjdJIMCtQ4r9H8zoL9y7PYBFvcOK9f8qQF5JxjGVrKDiMjo/yBQ/PEeG+ezwsrmg9Ro
	0VFOr8lpbDB0Xs794BmL3rQzJ5HgfbbD/QLrf98dbdwohZdm0pQaynX/NcF0ZZ0ZKt6Tce0UTHx
	RCIGTTkPYTPYmzKO+hWC8kxyWszE/pCIJS0Q0XZXHzo4x3UTASehcmQE+804jmR4=
X-Google-Smtp-Source: AGHT+IEfJzsl5sTUuHlfZV/CGAVouPssfIUHFzITNiPwgJ1+5lm4U750mnHyvBWvz6wm/EyMnnOAmg==
X-Received: by 2002:adf:f590:0:b0:3b9:13a4:72f with SMTP id ffacd0b85a97d-3b913a40db1mr890893f8f.14.1754996806833;
        Tue, 12 Aug 2025 04:06:46 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ee17535bsm257946505e9.16.2025.08.12.04.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 04:06:46 -0700 (PDT)
Message-ID: <e5b981f8-9b6b-42c6-b432-537d23f7fd58@gmail.com>
Date: Tue, 12 Aug 2025 13:06:46 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: handle 'use_ecc' parameter of
 qcom_spi_config_cw_read()
Content-Language: hu
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com>
 <3e790d99-5c6c-4148-85f5-0023a621afeb@oss.qualcomm.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <3e790d99-5c6c-4148-85f5-0023a621afeb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 08. 12. 11:55 keltezéssel, Konrad Dybcio írta:
> On 8/8/25 7:15 PM, Gabor Juhos wrote:
>> During raw read, neither the status of the ECC correction nor the erased
>> state of the codeword gets checked by the qcom_spi_read_cw_raw() function,
>> so in case of raw access reading the corresponding registers via DMA is
>> superfluous.
>>
>> Extend the qcom_spi_config_cw_read() function to evaluate the existing
>> (but actually unused) 'use_ecc' parameter, and configure reading only
>> the flash status register when ECC is not used.
>>
>> With the change, the code gets in line with the corresponding part of
>> the config_nand_cw_read() function in the qcom_nandc driver.
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>>  drivers/spi/spi-qpic-snand.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
>> index 7b76d2c82a5287df13ee6fcebc4abbe58ca861ee..119003c4784890458a41c67fa8bc17d721030b0d 100644
>> --- a/drivers/spi/spi-qpic-snand.c
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -494,9 +494,14 @@ qcom_spi_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int c
>>  	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>  	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>>  
>> -	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
>> -	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
>> -			  NAND_BAM_NEXT_SGL);
>> +	if (use_ecc) {
>> +		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
> 
> Why are we reading 2 registers (the 2 in the func call) here, ...

Because when ECC is used, we need the status of the ECC correction from the
NAND_BUFFER_STATUS register which is placed right after the NAND_FLASH_STATUS.

Here are the relevant definitions from the 'nand-qpic-common.h' header for
reference:

#define	NAND_FLASH_STATUS		0x14
#define	NAND_BUFFER_STATUS		0x18

So the two registers can be read with a single DMA operation.

> ... but 1 everywhere else?

When ECC is not used, we only need the value from the NAND_FLASH_STATUS
register, so we don't have to read two registers.

Regards,
Gabor



