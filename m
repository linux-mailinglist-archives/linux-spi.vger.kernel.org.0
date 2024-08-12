Return-Path: <linux-spi+bounces-4171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25D94EA32
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D142A28147E
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7D16DEBA;
	Mon, 12 Aug 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mc4Jjq6C"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F316B736
	for <linux-spi@vger.kernel.org>; Mon, 12 Aug 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455964; cv=none; b=bAAwM1Pfpf0vOSP5IS680vzQ8ydnnSxD76ECowbHbkmJyXVmV5G3P7vMtasvAyU6e1LPTExSO4sLaitdis3ZwlWRKd59je9wqqO/UoMaz20aN/n+AH3TBlXqMfk1YILut6OuF/L/OV7ztfuvCOO9RDFrUOINIxUyaFeeFJygemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455964; c=relaxed/simple;
	bh=JttXyWvNBrLovswX1EnPaJPxm1PSVZ+ohR3t2TiKVsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VobdPXXeayOE453lZqerxWhvCijqx58kQKBS1Khdlbsi88937/QoloZwepb9wkrimW8CRzuzCvyNvN09GmfUEPPf9AHY8l1s83WqMxz+yS39gS4Ac4G3CDM26yklXjM5SdDD5W+kiRP41caQDcxvSC2NgyM6sf2fDGQ4iPnBENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mc4Jjq6C; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so4100792a12.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Aug 2024 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723455961; x=1724060761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JttXyWvNBrLovswX1EnPaJPxm1PSVZ+ohR3t2TiKVsQ=;
        b=Mc4Jjq6CfTFem157MsUIbSwlDgogqRFbQP/swk6XmGsMwl4Oa98ZjlZiSS535k22FC
         Stz7ycnUmt6EcLxVdtsJdpkMkPNiq90j5Mt1jZeT1Yi00wJIYwphhaYIHRf67g5So9d/
         I+O0pqOh6xyEMmTev2UZgx6AHj5rDgC9eEbygz1EP4EX8Z4Lx7yUH/on3MmPdMkBZ/Fq
         kUVIZ2GOnS0mbKPpYBbMALQqnJhR1m2roDKY99DzaDyvM3z7sZr6Jw/4gWNUVyioD3rz
         eDxTYunU1DdIci6k8jVuXIMvUz9MvaL6+63FFzHnT0WsKYPyAMfFoIPLSdXGLbboPph+
         ebxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723455961; x=1724060761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JttXyWvNBrLovswX1EnPaJPxm1PSVZ+ohR3t2TiKVsQ=;
        b=HiRAlOVJUJ3uJdTjako1G7wgm3o2y+yflG6tWk9qkUNR3hhp1SFvR/Ep81ug0raPQp
         0MvY0Mrk2i+571yOO/YloZbatDsQvHVeHKNov5+HSIECttO4BbPCnNITeBTaEKIxS2s5
         Pgs/jU2llYEXxrT1s8IPZzryXKZRjepmVO4yej+P738HlrmmFAxK/CVraV2BaD0O+ex7
         zXqh+0E8DokYIw4tcwV7u4HGyb8/NRlhuO6MGL8l/gKraHAl7w7ZacCbwUdYyBgpi5pU
         VWmLdcLLYUpJEiO3B6wNHALghIdb2Z8TLnOVUbmqF8Tg17DOSeOtS8b5d4UFQOHexWsk
         7gJA==
X-Forwarded-Encrypted: i=1; AJvYcCVZFoWar566JIJi/DCs0Fhqzny6hqAcdBydae+HexdikftFOnQtjYiJl8v9FR7jMVAENXQlf4W+UjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXev+qrDsdarxPUnXsl4o+xnzQmGJmDcgH+zJ5f9q/e9lYtAN
	qFCZ/ePXGN3XQ1rY3Ji7MVGmBSAxp6VHLTtbT8ugdAM4pDlcq7FXrIed3Y16pJo=
X-Google-Smtp-Source: AGHT+IGaHEWZkOKxfoZJQYtrgry1CYeTIzGR/wr2t1cep4NpltsL9e4x6ljRA9qjxohlOrRIpWZzRw==
X-Received: by 2002:a05:6402:2346:b0:5a1:40d9:6a46 with SMTP id 4fb4d7f45d1cf-5bd0a6b4bf9mr6210531a12.36.1723455961053;
        Mon, 12 Aug 2024 02:46:01 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e04e1sm1967189a12.77.2024.08.12.02.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:46:00 -0700 (PDT)
Message-ID: <b96f483e-314e-4e47-af58-ddb078dd6df3@linaro.org>
Date: Mon, 12 Aug 2024 10:45:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>, "richard@nod.at"
 <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
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
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 "beanhuo@micron.com" <beanhuo@micron.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
 <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
 <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
 <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240812103812.72763f69@xps-13>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240812103812.72763f69@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hiya,

Amit, the thread becomes unreadable, better start a new one describing
what you plan to do.

On 8/12/24 9:38 AM, Miquel Raynal wrote:
> For now I don't think you need a totally generic implementation. As
> long as there is only one controller supporting these modes, I'd say
> this is not super relevant.


Miquel,

Microchip supports a twin quad mode too, and micron has some flashes
with similar architecture, see:

https://lore.kernel.org/linux-mtd/20231125092137.2948-1-amit.kumar-mahapatra@amd.com/T/#mbe999dde1d29371183aa53089ef6f0087d6902a7

We shall consider them from the beginning. I guess we need to read
everything all over again.

