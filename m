Return-Path: <linux-spi+bounces-285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD8C814352
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 09:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CB51F229AB
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 08:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249BE10A27;
	Fri, 15 Dec 2023 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZ6Arlfd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AE134CD
	for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33621d443a7so328513f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 00:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702627784; x=1703232584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBzycuIkV/6Qoafe8eFD9FYCTvqPcbdmnZw+dYA9ldA=;
        b=UZ6Arlfdk6GEz3XfxlpZdHG1UDtWW1XX/bjBHuAywy7VBGciB9NB4rhEoM6V819OlX
         we2mQaMKFRCLdDzT8ENVHPtv1rsia0jn5dL2DjcIMMNO7cfnaRUJqffWz4l89XLKL3yZ
         fCalsg4nj5c/LWfnWkmWY5ZzZE68mI2DQv/KmijqLiJy8QETjb2GwMkISfvn8uUhRV4d
         xDPOv30PWLDgT7diWj4Q9CKAzl3cmutX+ET3rmtKOTSHO5oRhQME/6Tx5lht5w1dYPv+
         6Z/lhBPM3hmF9QhSeYVCotaiqOVEDLM83yYsBirulzOG3ZRKyatYd40P2bOu6+iBsVU/
         p+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627784; x=1703232584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBzycuIkV/6Qoafe8eFD9FYCTvqPcbdmnZw+dYA9ldA=;
        b=hZ+opuP+ysm01rjnNhYCnjvIM1zS5if9dkb/su76DO3AiKyqgIJvlmVbdaqnV+1+Hg
         zO/Vt+34UL2QAzdYh1+JbSWl6QCCVeDJVsBIzFOiU/AQFAOC9BFiFi9BmQ1V7Mi2W7Fo
         2Z3SmgKU9x0LzdY9WgTZvRKotfZKmONPxQ04Yq8I0NfK0YGwDzAPcBFyrYMB+d0P/UHM
         Ch0WlloqFyr/+ZkjXYMmyam6p9+BRKPQ8VhAkpcWk4oAMTo5208nkNhncutEBz9ldfGc
         /K5+mn1zbVe346KeA2ulymUSgQqKuN+ZJgpvJ/k8CUkpcYRQsdJsZ6roYZK5o+Y8G6gc
         QtjQ==
X-Gm-Message-State: AOJu0YyM+rtVI9gdcy20hhYJT4ZbNAc0FuXDvNhC//xsXsj/N/WzkJeB
	fF7+OeE8GxQG1S4HUjN03XDxcQ==
X-Google-Smtp-Source: AGHT+IHXr2aiF67iw/MCg4WJKcEoWDnyX1a4J+sk1RcPb6DkmQzspdZfGa3WNYfB3GkmOcFIJZLRMQ==
X-Received: by 2002:a05:600c:1827:b0:40c:5c9:287 with SMTP id n39-20020a05600c182700b0040c05c90287mr5143077wmp.195.1702627784586;
        Fri, 15 Dec 2023 00:09:44 -0800 (PST)
Received: from [192.168.2.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d60cf000000b0033635ee4543sm7654960wrt.67.2023.12.15.00.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 00:09:44 -0800 (PST)
Message-ID: <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
Date: Fri, 15 Dec 2023 10:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael@walle.cc" <michael@walle.cc>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15.12.2023 09:55, Mahapatra, Amit Kumar wrote:
>> Thanks! Can you share with us what flashes you used for testing in the
>> stacked and parallel configurations?
> I used SPI-NOR QSPI flashes for testing stacked and parallel.

I got that, I wanted the flash name or device ID.

What I'm interested is if each flash is in its own package. Are they?

> 
>>>> can combine a SPI NOR with a SPI NAND in stacked configuration?
>>> No, Xilinx/AMD QSPI controllers doesn't support this configuration.
>>>
>> 2 SPI NANDs shall work with the AMD controller, right?
> We never tested 2 SPI-NAND with AMD controller.

I was asking because I think the stacked layer shall be SPI MEM generic,
and not particular to SPI NOR.

>> I skimmed over the QSPI controller datasheet and wondered why one would
>> get complicated with 2 Quad Flashes when we have Octal. But then I saw that
>> the same SoC can configure an Octal controller (the Octal and Quad
>> controllers seems mutual exclusive) and that the Octal one can operate 2
>> octal flashes in stacked mode 🙂.
> Thats correct .
> 
> Please let me know how you want me to proceed on this.

I got you. Still need to allocate more time on this.

Cheers,
ta

