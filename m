Return-Path: <linux-spi+bounces-103-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F97FEBBD
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 10:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB31C20AAC
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4D13715C;
	Thu, 30 Nov 2023 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYUBe5Nb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB304C1
	for <linux-spi@vger.kernel.org>; Thu, 30 Nov 2023 01:20:13 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9c39b7923so9169981fa.0
        for <linux-spi@vger.kernel.org>; Thu, 30 Nov 2023 01:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701336012; x=1701940812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6b6KMY0n/M+YsXFiDbvehOF3zPBGbEVpkXj4Ck+RiQ=;
        b=qYUBe5NbUG421ICdyVbZLL2FOGrYAQStxioh9oAH6v7FFdQdiKhTVgkoCMUCq8MnhK
         Qbkcolp6fGBEcEFCkoMibAn1GRGhOuVwSYeRZ1qGi5Q7eENPmtqpcM9ZRRV0XtXx04Z6
         C0Dpj2dPCBFqUwEfROS4T1yKMT1kV5pD94VSNs+Lwq8CFvPXwWTIrjQyRIKu8t8jzU6r
         bXsU5IAtefvdWNkQJiaoZ1WkC6i79UUEE6vH06tpuGK0Whr2q5VCZCWF9/RTpF8w0AsK
         Yf2qv5hXh41NCI6fGLfDXsWbK4nnqJhUJiTV0TudexR2vDivhiJ6LUgkmBsho4vJ7U3m
         cQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336012; x=1701940812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6b6KMY0n/M+YsXFiDbvehOF3zPBGbEVpkXj4Ck+RiQ=;
        b=Q/Clk+bPExObdKiqQBL7TQ1qI2Xs3BUakPcizUl3Nm/zRxs4+W5OQXSgAS2ZdZY64z
         MqmCZf54rbdxt27oJXtX4DxjlQVDmrRBYkuRGARVqVFYt55l6uyZ2HXmi55DnjFgKt7L
         GqRCtwo07Lku6BjGoDZedfTKOhW4QSJ9bIevW/BRS+OEJpBfs+exKW72UEqy5LiVN4N9
         jnl/NczSxHmORcMCTunBM+hyKio9JpbpKrt5djvRAAdM09aQZ37U+LlQgF3NF/VuyjjZ
         XlfO6c8Vxt/r3QyJ+TIlrXqRS4ckbsQE4G71vTuqlnAzP4Z51U+yI2d5jhuZR5pM3uVz
         YU/A==
X-Gm-Message-State: AOJu0Yw6IoiBxzMb/yeQqKOM1OP2Euba8RuImBDrEOd+mRYUh0gCRdKX
	whkbrzsr6IULm4q/qMX7i0AVwA==
X-Google-Smtp-Source: AGHT+IEaYhPPx9yJTn+Tt40iUWKql5jCkfrMLBxyzujYNVF6glNzpgT0IKlw+OZMcX2IHP9baN/WqA==
X-Received: by 2002:a2e:8ed2:0:b0:2c9:c0dc:b074 with SMTP id e18-20020a2e8ed2000000b002c9c0dcb074mr3036689ljl.3.1701336012029;
        Thu, 30 Nov 2023 01:20:12 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d44cc000000b00332c6a52040sm955607wrr.100.2023.11.30.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:20:11 -0800 (PST)
Message-ID: <ce0800c9-513c-41f8-bb02-43b2f1d60092@linaro.org>
Date: Thu, 30 Nov 2023 09:20:04 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: AceLan Kao <acelan.kao@canonical.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
 Kamal Dasu <kamal.dasu@broadcom.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Mario Kicherer <dev@kicherer.org>, Chuanhong Guo <gch981213@gmail.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231129064311.272422-1-acelan.kao@canonical.com>
 <20231129064311.272422-2-acelan.kao@canonical.com>
 <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
 <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/29/23 21:19, Mark Brown wrote:
> On Wed, Nov 29, 2023 at 07:46:02AM +0000, Tudor Ambarus wrote:
> 
>> You haven't specified who shall take these patches. Is it fine for you
>> if I take just the SPI NOR bits? If you want Mark to queue both:
> 
> I can certainly take both.  I guess there's no build time dependency so
> we could each take the subsystem specific patch, though there'd be some
> bisection drift if that happens?

Right, please take both then. Thanks!

