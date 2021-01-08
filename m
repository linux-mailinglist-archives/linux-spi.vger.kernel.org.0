Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81D92EEEFC
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbhAHI7s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 03:59:48 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52045 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbhAHI7s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Jan 2021 03:59:48 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 150FC1B5A;
        Fri,  8 Jan 2021 03:59:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 08 Jan 2021 03:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=N
        dnLowCP5uH4a2DVWClEdlATdNXRNG7vtXnjU4bygEo=; b=AtFxFxdbhyPC7sDfd
        znWRf27OwW5GQxjagKHR2hwFVjXS1y4xs3uwYGzCfKT9X4PJgTeb6gtk+PDVOJbf
        CGEgcSzKhScHBsGQcW/rwO02Gnff6pj7sXyDLgSbHC/MlmsKR/vGeKuyyR/Up2XI
        OU3foy0D8gi1YP5MNeEphGOtjaYUfs62MXbdd4g7/jP9mf88s6G6vs9hQ4v5f46b
        gGMpeV8jHQhYzSJaV74uS9NFwge6GGkmWMTWFVhrAmZOxVCB/kddEaI/QphD8RAb
        7ysoay77g3l7oELhYEyRRGaNO5ypLNx7+zwayfNM8fT+8eIL6i9EMW+ycGiCNwv1
        DG9Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=NdnLowCP5uH4a2DVWClEdlATdNXRNG7vtXnjU4byg
        Eo=; b=WoqmaM4xatrff68tDwix6rbKcoRGhtzDVP48YdR56TkPH1eGlQBWcDKno
        c/CXzU8vAuA5RJhpTFKVVWA6eFG4l03O4BNAThQFvlF2L8QuHVb3BNjmLJCaSIJ6
        yuHazf17H5fFvDu3Vrc5rK93ZI2LcmaFeY2jQPJw/VOyFztybhAuAkwNpTsYIDZx
        u9ddZcjh9WHipA3WPZAjfHRyO+KDNnZhB8myU3Kzreo96VlE6ayiXzE5LQpTNVAk
        SAuXaOpOq2IgjNA+a8Zehs+vQ9Kss2TDDKhLB8CaPfAXck6mIJjuA8mHrhbh61nG
        WcsOuZcWi1jrJ5E1hlY+lUlPrIcnA==
X-ME-Sender: <xms:0B74X4PbnqwHLQ-s1-WYK0dVX_OpX0ZFs2jwNKYlrfeD5WeeLllaxA>
    <xme:0B74X-9ElXdkSQpwt6UHPdUYmaa9pApJiWnlaRlH6zHMQTPdsuf53qpO85kbT2QLs
    CDsIYrYc4hPU5Bk2lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegfedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepteetffevuddtueeguefhteffjefhkeevveeuueeuffdtueejjefgffel
    leevhedvnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgpdhruhhnthhugi
    drtghomhdprghrmhgsihgrnhdrtghomhenucfkphepledtrdekledrieekrdejieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvg
    estggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0B74X_RrMcxcezMvqB-sbhoLsQoGouiSEX5LEvexmVX7N2OSLbzUow>
    <xmx:0B74Xwub27mqg68EENYJLBhcriLPK0g4P-rQfBxqmzZI993MAeLPXA>
    <xmx:0B74XweqNCRknw4NjZonqYLYNpt61Q_PFuFP8ckAW52UTSnYU2vWyw>
    <xmx:1R74XxpRMgmvJB26_wlkyUGxbjoWuWVmbaZRnlhgz9MpWZFJogFbEw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A929424005B;
        Fri,  8 Jan 2021 03:58:56 -0500 (EST)
Date:   Fri, 8 Jan 2021 09:58:55 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Fix SPI Chipselect/Clock bug for sun6i
Message-ID: <20210108085855.p255fioaax4zin4q@gilmour>
References: <20201226095845.c65lhsmluddvwxsl@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201226095845.c65lhsmluddvwxsl@runtux.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Sat, Dec 26, 2020 at 10:58:45AM +0100, Ralf Schlatterbeck wrote:
> This patch makes additional GPIOs usable as chipselects for SPI.
> It is available for years on the linux-sunxi SPIdev page at
> http://linux-sunxi.org/SPIdev and probably is originally by the user
> "Mirko" there. I've tried unsuccessfully to contact the author.
> Note that contrary to what is stated on the page above, the bug doesn't
> have cosmetic implications only:
>=20
> The SPI-Driver for the H2 Allwinner processor in the Linux kernel is
> supposed to support normal GPIOs as additional chipselects but fails to
> do so without the patch.
>=20
> For oscilloscope screenshots with/without the patch, see my blog post
> https://blog.runtux.com/posts/2019/04/18/
> or the discussion in the armbian forum at
> https://forum.armbian.com/topic/4330-spi-gpio-chip-select-support/
> (my logo there is a penguin).
> Please bear with me if I'm not following proper procedures, this is my
> first patch to the kernel in years.
>=20
> Thanks
> Ralf Schlatterbeck
>=20
> From 682ae1848b0df00cceb4c76486b971826b2737a9 Mon Sep 17 00:00:00 2001
> From: Ralf Schlatterbeck <rsc@runtux.com>
> Date: Thu, 11 Apr 2019 16:21:54 +0200
> Subject: [PATCH] Fix SPI Chipselect/Clock bug for sun6i
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
>=20
> The current sun6i SPI implementation initializes the transfer too early,
> resulting in SCK going high before the transer. When using an additional
> (gpio) chipselect with sun6i, the chipselect is asserted at a time when
> clock is high, making the SPI transfer fail.  This patch from the sunxi
> spidev page http://linux-sunxi.org/SPIdev fixes this, without the patch
> no additional gpio chipselects can be used. The relevant code seems to
> be from the user "Mirko" of the linux-sunxi wiki page, I was unable to
> contact the original author.

Unfortunately, without the author's Signed-off-by (and yours), we can't
merge that patch.

Maxime
