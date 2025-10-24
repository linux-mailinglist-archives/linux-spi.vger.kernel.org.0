Return-Path: <linux-spi+bounces-10806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A72C03EDE
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 02:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2041AA3018
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 00:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E82B9A7;
	Fri, 24 Oct 2025 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="erOz7Tk8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283115530C
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264259; cv=none; b=feZWFL+hixxfN8Nh/Tky6i/QLlG0UM9SJJOteIaY6NYMiRj1hp9ieB5Lm5S+gGpdblVQ7yBuTkIr1q3xq8BE0fyGivHGgrVvZdsIMdel34L3fh1nkfD+8tc+8UeHXyGbrmXqpzW8zc7zCnw2agL5BOv4k3aTb/WsWmAaCdJRTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264259; c=relaxed/simple;
	bh=0a1a4wJl0mNN+XeKmiOrjUVWC1hr2y3wlT7/+yelLHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyQvb/MPYMcCMkb4bgFoZZA4EUDTqLoL+pWoS7SZmkMhFTClFeZVYjx54ZljnSSvFY6rYH4zeUHEUuQiTBSXkUuAmRaOvUtAps8Id8QeU3aFRMHSzkFiuvpV3XDaf5Yv3zlBd+1WRLhfdRUotQ2XoHJytWi+MolQVOG/lrf73FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=erOz7Tk8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1496422b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264255; x=1761869055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=st9SBmAbK+pJ23fMLr1ycY9DK+4vkS9Hx7Sl87k4JR8=;
        b=erOz7Tk8sM7M+Y/v6P02GMG2F3Q3yZ/otgZ3vwE0+Ao/pLVY/L3KNtVHY/ILnHMLlS
         jziWnEZZY+3fFWaUdGG4FC9B5Kp/H3rouKhpiR8vhXrgcap3pxIqMcpt1FLE/F40hcVj
         NGxtnyTPf+6bQFzLYNBUKB0A2KjSdWml+Ow5gi5HzL+SHchk4daSaaaV0/s8J2KIZ51Z
         f0FUXx3aQ/iv6hb5kRH5BTNxTtyJVKu6DZneS0CyX4ZAPdyymfAQXsplxOrX85OxImdH
         D2NVAkVMKEMN6PYxPqoTMmdMgkDiHzTaXt7YnM9J1qwDEPq/imObsKlZ0gUf5BYHkILI
         YmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264255; x=1761869055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=st9SBmAbK+pJ23fMLr1ycY9DK+4vkS9Hx7Sl87k4JR8=;
        b=GsRvWlOA6yxefnInSkcIinAp9sz0x9Lpc/vuIh48ev88ptKmV6yOEfQz23yj0R05OY
         KluoNtSrs/Ew8n+B80Dy0t2gLfWMoI1ElYQwfySIObOsVSMvMh7afUIQmrrIJboqDCfG
         Z9++8+HIWHYyo7el1YVq6JG7cWzLldKxfGiI8hf+ZAw4IFE8hL6Q6dxVTTITBkjFvRYY
         IUCVFnriLQjllMoqnr6/VEcL2cEcNeXpQjX1TCWFYq6bm/JoHStTgD7qDO+O55vJiogF
         vfcOWeVL3xG0/IHUR82zcrvXavwFAgFhCRnHBOodw1JacynRpJE0zE/n0kFoVcngho1x
         WSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYXUp5rXIzWETqq7OJlij82YYzzUoao8Oe+BGJIjhYuiHlmJC18GCWJUJ83+/ZJojjbDMesml+HEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZE7RdEoKY77Xk46+BYtQyjbSf4/+8lnVjzxGMjL5xgezbnyaE
	8ySWTifhSiAw7NfHR4lxchoX/inSl01AKEZFq0eMgdePyDOn2BGh+z0PWvSZ0I35eetOYCmFBb4
	Xt/y0YuY=
X-Gm-Gg: ASbGnctK8YnygZfzUOCM8SFuqorvvw0hVlthUhTqeU3wQfwxTcfnBzt53xAyloxPcu2
	ZKj/aKNUY18odTwZcynUahUr4r/0OTxiFdr2PNkJ0aLhqTpkPyqQKjW2Z4p0JBNECxTIL7gLbTQ
	didhzfMEE0rTekr6pY1bxdBo3WJUEpL1XrcbWtfkwIB9DncEmhOhjOgrq4NQFtNOkGOhtppzU6G
	qSMn1PxUcAYQh6kb/hLKfkinOmzFlDKes9u7mbyr5PgaBS5WN/B9fmud0fKZy7jSisZm/Xwv7qC
	W32CYk82JMGdKLZ/kpHMNzltEyclZ+2gDBOqSRGoRLK1bBxOA2ISrwbRitreiFrhVjH/hw5lGnA
	jgWl5hgO20JGDLVF/7/VlUESui6v22Ewg3s/c/IAma8KeCAZqiS3W3DXz04i0yq7uRu+fM5cHyQ
	6nKfP4iWIkcFLGYv0Dfo/vVuFDTTM=
X-Google-Smtp-Source: AGHT+IG4cAqt2nwKmVZj2ECX6/woNYxm9obKHW2gmp+s3pOMBjf8gp6N1gNa2I6RxiJ8JXE2VP7MyQ==
X-Received: by 2002:a05:6a20:394b:b0:2c2:f61b:5ffd with SMTP id adf61e73a8af0-33db34e5145mr934623637.10.1761264255098;
        Thu, 23 Oct 2025 17:04:15 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:14 -0700 (PDT)
Message-ID: <aa306536-f09b-414c-9e6d-0b69d69040a4@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:14 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] spi: fsl-qspi: allot 1KB per chip
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-7-elder@riscstar.com>
 <aPq8ibj2KzQhtYQT@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPq8ibj2KzQhtYQT@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 6:38 PM, Frank Li wrote:
> On Thu, Oct 23, 2025 at 12:59:18PM -0500, Alex Elder wrote:
>> In fsl_qspi_default_setup(), four registers define the size of blocks of
>> data to written to each of four chips that comprise SPI NOR flash storage.
>> They are currently defined to be the same as the AHB buffer size (which is
>> always 1KB).
>>
>> The SpacemiT QSPI has an AHB buffer size of 512 bytes, but requires these
>> four sizes to be multiples of 1024 bytes.
>>
>> Define a new field sfa_size in the fsl_qspi_devtype_data structure that, if
>> non-zero, will be used instead of the AHB buffer size to define the size of
>> these chip regions.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - New field fsl_qspi_devtype_data->sfa_size now defines the size of
>>         the serial flash regions if it's non-zero
>>
>>   drivers/spi/spi-fsl-qspi.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index c21e3804cb032..a474d1b341b6a 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -207,6 +207,7 @@ struct fsl_qspi_devtype_data {
>>   	unsigned int txfifo;
>>   	int invalid_mstrid;
>>   	unsigned int ahb_buf_size;
>> +	unsigned int sfa_size;
>>   	unsigned int quirks;
>>   	bool little_endian;
>>   };
>> @@ -737,6 +738,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>>   {
>>   	void __iomem *base = q->iobase;
>>   	u32 reg, addr_offset = 0;
>> +	u32 size;
> 
> I think use 'sfa_size' is better to read code.

OK I'll rename in the next version.  Thanks.	-Alex

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>   	int ret;
>>
>>   	/* disable and unprepare clock to avoid glitch pass to controller */
>> @@ -795,17 +797,17 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>>   	 * In HW there can be a maximum of four chips on two buses with
>>   	 * two chip selects on each bus. We use four chip selects in SW
>>   	 * to differentiate between the four chips.
>> -	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
>> -	 * SFB2AD accordingly.
>> +	 *
>> +	 * By default we write the AHB buffer size to each chip, but
>> +	 * a different size can be specified with devtype_data->sfa_size.
>> +	 * The SFA1AD, SFA2AD, SFB1AD, and SFB2AD registers define the
>> +	 * top (end) of these four regions.
>>   	 */
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
>> -		    base + QUADSPI_SFA1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
>> -		    base + QUADSPI_SFA2AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
>> -		    base + QUADSPI_SFB1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
>> -		    base + QUADSPI_SFB2AD);
>> +	size = q->devtype_data->sfa_size ? : q->devtype_data->ahb_buf_size;
>> +	qspi_writel(q, addr_offset + 1 * size, base + QUADSPI_SFA1AD);
>> +	qspi_writel(q, addr_offset + 2 * size, base + QUADSPI_SFA2AD);
>> +	qspi_writel(q, addr_offset + 3 * size, base + QUADSPI_SFB1AD);
>> +	qspi_writel(q, addr_offset + 4 * size, base + QUADSPI_SFB2AD);
>>
>>   	q->selected = -1;
>>
>> --
>> 2.43.0
>>


