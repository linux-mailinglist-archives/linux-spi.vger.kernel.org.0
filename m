Return-Path: <linux-spi+bounces-12449-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9172D3864A
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 20:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C31DC30E37DD
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFE3A1E77;
	Fri, 16 Jan 2026 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Gi1zEhMQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957613A1D1D
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593376; cv=none; b=JuMgFmIl21PVj8cNIfdqEaUR3tRY+TZthSL152sbDrwk9tpWYavSvYdoLP5sFl5WG/02sZHEoBy28efc8aGx9NNkvZqfZmUQwqQO8guqs7TnbmHnbth5kaLtWd5ijPyI9ptZhUAqrYX/6vxef+6/b6cF93AtCxXZnWWh239amhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593376; c=relaxed/simple;
	bh=z+/ZZ09hPbSFonH/aNw3tFrc5+PnaadjuQ7TnoFy16I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RScIA/nS7ktfkQskPfvPA0TvqqIIVPmqCz9t3ngX0rMTRZIQD+x0S6m+YeVgN2yTRCrpeTJWXeADsHBVSZrmGfRRCMiG/CJFw3PdV4txTwDhCSb0Gvur5dsqbe62lixpe0Nq8uqGiWmcsmg7+5C2Ebomqled1r1S4VNwxZhDqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Gi1zEhMQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f42a49437so1315830b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 11:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768593373; x=1769198173; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa0+snq05PA6LQZljIwRr0Hddt3kF9aOaEZOA0BQCJo=;
        b=Gi1zEhMQhI1M5GcdL66XBikVGBagr9/X0bydVf9GRXbfk88ISpujvu/vwEatfuWZgW
         XmAqMnP24hIa+sc8HJ4Fb/9msNbmCbfiB3P56FEBE1ZlyF1fVOEHvRDooQcafUIptoif
         8Oo+kGi9pEwSfb0TImoPxly+IiaOucfmeei7U5hjcylJarhIIZo8DCJ8leRyedcIc0MC
         ztImGQA9PeXw+5z5vJ4w3qKBlIr3Mk2jjgnChGaOvmkimcmBmSrwEHq6VC+i+1sdJJTF
         3ofiRSNCscFt6grFaG6dWaxqZrcVK+yYKJfr5awFmpx1Q6WxQRPwQiUI7g+FD4lb2/5O
         CGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768593373; x=1769198173;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aa0+snq05PA6LQZljIwRr0Hddt3kF9aOaEZOA0BQCJo=;
        b=nZWT7XsLpsd8nZaRwSIeKAmhX7bMQAZlFQMSramu52UNSV6gpIAhtb99vjKjK5U0gG
         IIA3Muwh2ZfOPoWywg56D4ZSZojIotqoAyKCZbY9suVC+wgxdqAt4HI2/3CPT4YfVMSe
         NmBd9Wm7mx5UITD5eN4vmXSKwFVsWzDLC0Lr3wzNzRMVed/zR/8sluDgr9FYTHGUkUtU
         LVRWFxpbZHfbzAzXLi5UK97sxdumKlXEKjI28mkUQpKSKoRzxA/4rDj6pnN22+RtyADI
         Gz4+92+Tv3x6dxEj1y9ezEpHJ0JvL9U4NLzdnwYFIugxfGKj1IFD8B2kN0N/FIVX+CXy
         cQFg==
X-Forwarded-Encrypted: i=1; AJvYcCXXr63lr+YD7XEYq9zoCxR2VzXt7K9LuYB0IUURUS0O3sxueLWeOCAcXcoqrWIPsJj+3mVP9ofdEoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnkEqKZoi1KfEXYAlUj8v7IBHyVbDkHrRia2rIK1ZFotTqUpb7
	5kDT8HyQHousItzNpplskIu4MP25fXuFGfSfg//Hd404NZBzH23tswt1tlLe3lKRII8=
X-Gm-Gg: AY/fxX4wk+JXdkHz1yMbrzHT9830DjNMoLvQwVXETqLrPGipxrapEBOnxq3ElpwY2qS
	MNAKjK7STMtU6ydw3hY4iQJtPdYbmjjGgCOgGudtCSQSuO7ZO/SG+/whVCifutsLWmSosyKmLEW
	GYHMR8Sjm2gO0lH9gslkJrOpSDax2x+L2j2QcS5kLXQBvPBubKx2MoTMlOHZergWvouiKjMr7CV
	VMjcaTGkn5lhoNnq7DvUxGNqMuwbVDnyeiOxcqMIWlKCsoFBWqiwPfL1yuu0JA3cH7gKX32lD7r
	5nvqDrzhuBA4D5vZ7TulbC+lZuqo69j2TJhyW5QElfVOM03v9HkFmDNWiHd5Qqd+zBjeAA4r33E
	nXer2Yvm9IZ4b9B9TCUghY/qX0awSsU9rY0VJpCYEs8O2qmx2OwppUtPMscAzFvSPyE50jt5Bdk
	KgCukNADW1MZ2YHjyfK3AvPWZkJD+ubWKtOMX5KE9opRTlwP2S8R0uqN56R0hrEu2jLAepwG0=
X-Received: by 2002:a05:6a00:2e04:b0:81a:b602:daf6 with SMTP id d2e1a72fcca58-81fa030a989mr3690746b3a.48.1768593372649;
        Fri, 16 Jan 2026 11:56:12 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291135sm2705239b3a.47.2026.01.16.11.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:56:12 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] spi: xilinx: use device property accessors.
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <b3c81793-32f8-4b2c-a32d-bc90024580ca@amd.com>
Date: Fri, 16 Jan 2026 11:56:01 -0800
Cc: Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E28E6728-2FF2-4AD9-B2EC-89A917A23D6D@nexthop.ai>
References: <20260115003328.26095-1-abdurrahman@nexthop.ai>
 <b3c81793-32f8-4b2c-a32d-bc90024580ca@amd.com>
To: Michal Simek <michal.simek@amd.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 15, 2026, at 11:51=E2=80=AFPM, Michal Simek =
<michal.simek@amd.com> wrote:
>=20
>=20
>=20
> On 1/15/26 01:33, Abdurrahman Hussain wrote:
>> This makes the driver work on non-OF platforms.
>> Also, make irq optional, since the driver can already work in
>> polling mode.
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>> ---
>>  drivers/spi/spi-xilinx.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
>> index c86dc56f38b4..9fb1da2fcce4 100644
>> --- a/drivers/spi/spi-xilinx.c
>> +++ b/drivers/spi/spi-xilinx.c
>> @@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct =
platform_device *pdev)
>>   bits_per_word =3D pdata->bits_per_word;
>>   force_irq =3D pdata->force_irq;
>>   } else {
>> - of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
>> -   &num_cs);
>> - ret =3D of_property_read_u32(pdev->dev.of_node,
>> -    "xlnx,num-transfer-bits",
>> -    &bits_per_word);
>> + device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
>> +  &num_cs);
>> + ret =3D device_property_read_u32(&pdev->dev,
>> +        "xlnx,num-transfer-bits",
>> +        &bits_per_word);
>>   if (ret)
>>   bits_per_word =3D 8;
>>   }
>> @@ -471,7 +471,7 @@ static int xilinx_spi_probe(struct =
platform_device *pdev)
>>   xspi->bytes_per_word =3D bits_per_word / 8;
>>   xspi->buffer_size =3D xilinx_spi_find_buffer_size(xspi);
>>  - xspi->irq =3D platform_get_irq(pdev, 0);
>> + xspi->irq =3D platform_get_irq_optional(pdev, 0);
>>   if (xspi->irq < 0 && xspi->irq !=3D -ENXIO) {
>>   return xspi->irq;
>>   } else if (xspi->irq >=3D 0) {
>=20
>=20
> I expect this is another IP which you are using on systems with ACPI.
> Can you share ASL fragment you use for testing?
>=20
> Thanks,
> Michal


Yes, that=E2=80=99s correct. We are using AMD Ryzen Embedded V3C48 based =
system with AMD (Xilinx) Artix 7 based FPGA using I2C and SPI IP blocks. =
The SPI block currently doesn=E2=80=99t have the interrupts working =
correctly (yet), so we disabled the interrupts. This is what the ASL =
fragment describing the SPI device looks like:

            Device (SPI0) {
                Name (_HID, "PRP0001")
                Name (_CRS, ResourceTemplate () {
                    Memory32Fixed (ReadWrite, 0x80950000, 0x00000200)
                })
                Name (_DSD, Package () {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package () {
                        Package () { "compatible", =
"xlnx,axi-quad-spi-1.00.a" },
                        Package () { "xlnx,num-ss-bits", 5 },
                        Package () { "xlnx,num-transfer-bits", 8 },
                    }
                })

                Device (NOR0) {
                    Name (_HID, "PRP0001")
                    Name (_STR, Unicode ("TH5 Boot Flash"))
                    Name (_CRS, ResourceTemplate () {
                        SPISerialBus(0, PolarityLow, FourWireMode, 8, =
ControllerInitiated,
                            120000000, ClockPolarityHigh, =
ClockPhaseSecond,
                            "\\_SB.PCI0.GPP6.FPGA.SPI0")
                    })
                    Name (_DSD, Package () {
                        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                        Package () {
                            Package () { "compatible", "jedec,spi-nor" }
                        }
                    })
                }
            }

Thanks,
Abdurrahman=

