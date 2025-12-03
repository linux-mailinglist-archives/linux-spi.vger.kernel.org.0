Return-Path: <linux-spi+bounces-11747-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75894C9EA75
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 11:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 061684E03E4
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9792E7BD9;
	Wed,  3 Dec 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVVwiS19"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654AE2E7648
	for <linux-spi@vger.kernel.org>; Wed,  3 Dec 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756712; cv=none; b=jZRuynmD9SPd1KsaFg5gJNhi7JE29aQKASdi2Zbp+8e3gfS8ZzJ6rctUEuKTKm7Ta7LgA1vmMugY99Dgq3gBcaUoN+0AH/UaNOtDMqYB0gV0+3FxPeO4e29vXvFngLnx/FmRePqF2sn+18ryBRYavkOOA55f2V/L8DNeefD5kvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756712; c=relaxed/simple;
	bh=yy2j4Gr2kBYId3840eqEXHigGss3DzYkeqaEM7aYlHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pex50wnX+DHpgJyC2QXacX7hEsYWsDLa51URpjHc0tLpSrjEvTdKMjJe49fURNSEK6FnMGCFFCmkbNrex2myydgbYUN/zIniH4IpLt5xdZmyq+BspcPhCWjdF/4sTQBO/M+50e4xRWoIVXgkk2VUwMcCAYjIcMVnQ8kESgFrYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVVwiS19; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b999d0c81so54021681fa.2
        for <linux-spi@vger.kernel.org>; Wed, 03 Dec 2025 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764756708; x=1765361508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hkzMjIodS1pI1goTlzUE28NNMhc2FNCH6n3nOuMBQE=;
        b=cVVwiS199FQzTPZrJ1RWhtR3m7QFvHLsF45rNZfVbfj9qtNIV06hYnMvxvFU671pPo
         jNFsDj3N6vSL+e5r4hVZE7ZJk1s5RH2SRIFQJgjmR8DyqUy/9H6lcU93e3grwNL4W1a4
         pqol5i2GpZAoSIuV3IR1gXmEGOKn37seOgNtM65LiYJ9WNp5q4U1W/+QvKXz0geju4u9
         jq8QZAeMgZpqvTBfOk0bKcnRfbU7ir7u8H28929zJPytVqwAgT0WQfzbO05m1qptqWrQ
         U5Vzce1f9MtaoLmgnv8nxTubFt/c5e064Ok28SfQD2H7+CoYJA7hf5FgThwVv8DbNS9H
         P3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764756708; x=1765361508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hkzMjIodS1pI1goTlzUE28NNMhc2FNCH6n3nOuMBQE=;
        b=RzZOr8LKKfrmrMxpuEdRIxLGgFFBL/UiDag66xKRRtYBfh6ykjRJgyBYOU7iwg1ZNY
         d19prnpjt6TdWIlWpT/1DbgH8jxVNMWCoMe02p3nDaj8Npf6O9WAyxGFLX2a4NYe8RMD
         aWLkmrKbz5Q3qF8hBHGHSFEcMmbAhjR5ZwmK7eUlUs7JQm5hFMkA+3Y0sk33U1qYI9Ns
         6WevPCW94J37dw6Qat8yALIHjqFr9+c+sinS5pPeGPXFG7JQ0NPX+2do+WZGl+/9xckn
         vn+gIfFCSaGtmHh8ea0MicBYgOd3hj81Ez5xzN8+C3CHw3wksCo9Pb4DyrPRz/EWUZ84
         z0PA==
X-Forwarded-Encrypted: i=1; AJvYcCXniDlSmZD1qvZHD4SRwtGAxkjsJJA2L7LNQVigrREjKnysrBGTFqHInYotJjFChDlZWQi5yNKGHNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3HWL+LRWraz/cFrplsh3sy+jPSdEzjxQzsuXbZBqp2fXQENL
	rYg0HanicMI6it595OpjPsjH4LsRFjv9t6xIZg74jc0nCT+kgg7wHqcj
X-Gm-Gg: ASbGncty6m6oY5d66C5QcQy13hGr4fyQdATBzRMi5DHa3P5dggLK8df6tkMQ8Ed2/qU
	d5fJ7Z5TC7iDfLXTN3XMuL8I2vz5cD6CdXwT0ew7seC67YZBU1/62fJsRfCFLiwv7inikIwDvYy
	77ZWhqS7q5nSRxegJ47DOxOJHwXsJggy/W54dGWn6zg7mAUZZSXYqAKCtQLK6v/0afKhWHl39gv
	WxVkgCghEKJJ3vAkP/EIPSRF16m6ZSDSbA5EIFb0tAcjgS0RKZ9Jj0s26y3GpRMjyGO8f5Hq4zB
	pfZ4yhhhT2Ib6i8AjHvTQAxc84eW3MDxjAK4qca9iCPIoaiCM/ydLs8pThABq9LTjHQ/sC8GgoF
	lqfHXqrhHtOp99e1/2vQ3a10YKgP9CG+5c9NuCRw+PDrbT9hjZJVsGqyS8qSGJYd9Zi4t3i00Rb
	mQ018NfvOpkOH1ig==
X-Google-Smtp-Source: AGHT+IGClRjrRzHtx62krt4asIMCvQHnP6xr/r5CpGOAwQrXHtwf7m7w8S9UGWZzoda9nXqVUQIx4Q==
X-Received: by 2002:a05:6512:12c4:b0:595:7d86:f654 with SMTP id 2adb3069b0e04-597d3fb539emr853943e87.26.1764756707102;
        Wed, 03 Dec 2025 02:11:47 -0800 (PST)
Received: from [10.38.18.76] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8a7b2asm5560144e87.12.2025.12.03.02.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 02:11:46 -0800 (PST)
Message-ID: <dc813fc2-28d2-4f2c-a2a3-08e33eec8ec7@gmail.com>
Date: Wed, 3 Dec 2025 12:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com>
 <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
 <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com>
 <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
 <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com>
 <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
 <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com>
 <20251202102619.5cd971cc@bootlin.com>
 <088af3ff-bd04-4bc9-b304-85f6ed555f2a@gmail.com>
 <20251202175836.747593c0@bootlin.com>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <20251202175836.747593c0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/25 18:58, Herve Codina wrote:
> Hi Kalle, Matti,
> 
> On Tue, 2 Dec 2025 13:21:16 +0200
> Kalle Niemi <kaleposti@gmail.com> wrote:
> 
>> On 12/2/25 11:26, Herve Codina wrote:
>>> Hi Kalle,
>>>
>>> On Fri, 28 Nov 2025 10:34:57 +0200
>>> Kalle Niemi <kaleposti@gmail.com> wrote:
>>>
>>> ...
>>>>>>>>>>
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> Test system testing drivers for ROHM ICs bisected this commit to cause
>>>>>>>>>> BD71847 drivers probe to not be called.
>>>>>>>>> This driver (and overlay support) is in linux-next or something out of
>>>>>>>>> tree on top of linux-next?
>>>>>>>>>
>>>>>>>>> Rob
>>>>>>>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c
>>>>>>> I don't see any support to apply overlays in that driver.
>>>>>> Ah. Sorry for the confusion peeps. I asked Kalle to report this without
>>>>>> proper consideration. 100% my bad.
>>>>>>
>>>>>> While the bd718x7 drive indeed is mainline (and tested), the actual
>>>>>> 'glue-code' doing the overlay is part of the downstream test
>>>>>> infrastructure. So yes, this is not a bug in upstream kernel - this
>>>>>> falls in the category of an upstream change causing downstream things to
>>>>>> break. So, feel free to say: "Go fix your code" :)
>>>>>>
>>>>>> Now that this is sorted, if someone is still interested in helping us to
>>>>>> get our upstream drivers tested - the downstream piece is just taking
>>>>>> the compiled device-tree overlay at runtime (via bin-attribute file),
>>>>>> and applying it using the of_overlay_fdt_apply(). The approach is
>>>>>> working for our testing purposes when the device is added to I2C/SPI
>>>>>> node which is already enabled. However, in case where we have the I2C
>>>>>> disabled, and enable it in the same overlay where we add the new device
>>>>>> - then the new device does not get probed.
>>>>>>
>>>>>> I would be really grateful if someone had a pointer for us.
>>>>> Seems to be fw_devlink related. I suppose if you turn it off it works?
>>>>> There's info about the dependencies in sysfs or maybe debugfs. I don't
>>>>> remember the details, but that should help to tell you why things
>>>>> aren't probing.
>>>
>>> Rob reverted patches but I plan to continue my work on it.
>>> On my side, I need the reverted patches but I fully understand that, on
>>> your side, you need a working system.
>>>
>>> In order to move forward and find a solution for my next iteration, can you
>>> send your overlay (dtso) used in your working and non working cases?
>>>
>>> Best regards,
>>> Hervé
>>
>> Hello Hervé,
>>
>> I have attached the overlay source file: bd71847_overlay.dts
> 
> Thanks a lot for your overlay.
> 
> I did an update of the reverted patches and I didn't detect any regression
> with the update applied on my use case but I don't have the needed code to
> perform tests similar to your use case. Indeed, you apply the overlay using
> an out of tree code.
> 
> May I ask you to perform a test of this update on your side?
> 
> First you can use the last linux-next kernel where reverted patches are present.
> The next-20251127 tag is a good candidate. Indeed both patches are present:
>    - 76841259ac092 ("of: dynamic: Fix overlayed devices not probing because of fw_devlink")
>    - 7d67ddc5f0148 ("Revert "treewide: Fix probing of devices in DT overlays"")
> 
> Of course, be sure to have the issue using this kernel with your overlays.
> 
> Then can you add the following modification on your faulty kernel:
> ---- 8< ----
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 1528d8ad9f26..aea7bb26d9c4 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -190,6 +190,20 @@ static void overlay_fw_devlink_refresh(struct overlay_changeset *ovcs)
>          for (int i = 0; i < ovcs->count; i++) {
>                  struct device_node *np = ovcs->fragments[i].target;
>   
> +               /*
> +                * The device related to target node itself could have been
> +                * removed and re-added. This happens when the 'status' property
> +                * in the target node has been changed by the overlay.
> +                *
> +                * In that case the parent node needs to be fixed.
> +                *
> +                * Before fixing the target node itself, fix its parent. To keep
> +                * things simple, fix the parent in any case. If nothing needs
> +                * to be fixed, fw_devlink_refresh_fwnode() acts as a no-op.
> +                */
> +               if (np->parent)
> +                       fw_devlink_refresh_fwnode(of_fwnode_handle(np->parent));
> +
>                  fw_devlink_refresh_fwnode(of_fwnode_handle(np));
>          }
>   }
> ---- 8< ----
> 
> My hope is that this modification will fix your issue.
> If so, I will add it in my next iteration.
> 
> If you cannot perform the test on your side, can you provide me the out of
> tree code you use to apply the overlay?
> 
> Best regards,
> Hervé
Hello Hervé,

I tried this patch on next-20251127 by manually adding the added lines 
to /drivers/of/overlay.c, and it did not solve the issue. I will 
continue to test this.

BR
Kalle

