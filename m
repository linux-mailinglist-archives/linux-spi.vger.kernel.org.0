Return-Path: <linux-spi+bounces-12297-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4324D13060
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 15:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EFFC3009131
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507DF1D555;
	Mon, 12 Jan 2026 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CakAumhF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87747154425
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227108; cv=none; b=MDRAKz+v+A5Vn1mi2PH2vmBVxIvdQfZlURm7kkJ5bjifqJ5t22aGylQ/39lwQWr2KF0tA4ZJFe8wXqDlS15JqbSuhEuArQ83kT1t13OB7FDwvfuRP4ireODsVlQzBUUAAlRtb/QUIQTYl/X7K36Za1Q6T/FLon0x/t3y4CKArJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227108; c=relaxed/simple;
	bh=bgJaNUM5VIgE3jmg2aRlC1+4Tim4pBQlk9u6DJ16NrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5bNO/OhY09KuYxkdxzYOBYZPdo0W6GCL45axgTDPUtKibGRfcW8ljxATrLZ8feTW1VUO6+kxyI0lXob+Mhii5YDz+LZ19pAIk1GDA83zbIBv/4kO0r+5l3mmFk0gvs3XHMxHWt0UoGKFL7Bwn4n9JdIiWQjwt0QdztXmcAm48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CakAumhF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5059C1A27F1;
	Mon, 12 Jan 2026 14:11:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D1FB6074A;
	Mon, 12 Jan 2026 14:11:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 736BF103C8C61;
	Mon, 12 Jan 2026 15:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768227090; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S8c2ARP9HcnV+reUeOF4Vcg2quHBkPmCAqYrhfyr6c0=;
	b=CakAumhFpasu+3ZI3BaB812kdRiuu+v1Tg/Sp3TTEi8pdVKDZEtVO84AoLEgEc1xrnFluT
	i+SAwVNTU/VK298rD4GgfOlbL1x1IRBq+LMtmjrslvr8iNw/wqHBq7SowNZ+1bxrqAdaPR
	ziVMPo032s+fSJqG9mpYJmDIazpKyi53yb/qGj1zj4VwwbAj77lJfzPnCy7GfnRvSCaoiG
	VLNhV0T9IC//MbbHQG1tnGAF03XNmqvN+K3xG6/Renyw+hJ5Ia+fO3n6d7mTvuZI7e4oUm
	CIup66ln9btW8iWglHRpKXcMS5I6EydGAat63GN0yLYYuyDF497mBLdXxOQ06g==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
 Varshini Rajendran <varshini.rajendran@microchip.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sunny Luo <sunny.luo@amlogic.com>, Janne Grunau <j@jannau.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, CL Wang <cl634@andestech.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 David Lechner <dlechner@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Hang Zhou <929513338@qq.com>,
 Jun Guo <jun.guo@cixtech.com>, Philipp Stanner <phasta@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Shiji Yang <yangshiji66@outlook.com>,
 James Clark <james.clark@linaro.org>, Jonathan Marek <jonathan@marek.ca>,
 Carlos Song <carlos.song@nxp.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Huacai Chen <chenhuacai@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
 Sergio Perez Gonzalez <sperezglz@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Qianfeng Rong <rongqianfeng@vivo.com>, Haibo Chen <haibo.chen@nxp.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Rosen Penev <rosenp@gmail.com>, Luis de Arquer <luis.dearquer@inertim.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Longbin Li <looong.bin@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Le Goffic <clement.legoffic@foss.st.com>,
 Alessandro Grassi <alessandro.grassi@mailbox.org>,
 Chen-Yu Tsai <wens@kernel.org>, Darshan R <rathod.darshan.0896@gmail.com>,
 Aaron Kling <webgeek1234@gmail.com>, Vishwaroop A <va@nvidia.com>,
 Haixu Cui <quic_haixcui@quicinc.com>,
 Darshan Rathod <darshanrathod475@gmail.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, asahi@lists.linux.dev,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-rpi-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, imx@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, Anand Gore <anand.gore@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>,
 Yang Shen <shenyang39@huawei.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lixu Zhang <lixu.zhang@intel.com>,
 Yinbo Zhu <zhuyinbo@loongson.cn>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Heiko Stuebner <heiko@sntech.de>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Andi Shyti <andi.shyti@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Li-hao Kuo <lhjeff911@gmail.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
 Michal Simek <michal.simek@amd.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v1 4/4] spi: Drop duplicate device_set_node() call
Date: Mon, 12 Jan 2026 15:10:36 +0100
Message-ID: <2776743.vuYhMxLoTh@benoit.monin>
In-Reply-To: <20260108203004.3538449-5-andriy.shevchenko@linux.intel.com>
References:
 <20260108203004.3538449-1-andriy.shevchenko@linux.intel.com>
 <20260108203004.3538449-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

On Thursday, 8 January 2026 at 21:23:41 CET, Andy Shevchenko wrote:
> The SPI core provides the default fwnode for the controller,
> assigned by device_set_node(). No need to repeat it in the driver.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>  drivers/spi/spi-dw-core.c           | 2 --
>=20
Works fine on Mobileye EyeQ6Lplus SoC in both host and target mode.

Tested-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com> # dw mobileye

Thanks,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




