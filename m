Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9814E4E8D0E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Mar 2022 06:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiC1EWM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Mar 2022 00:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbiC1EWL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Mar 2022 00:22:11 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9DB4F9E4;
        Sun, 27 Mar 2022 21:20:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 097325C013A;
        Mon, 28 Mar 2022 00:20:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 28 Mar 2022 00:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=pUVEwGHg7/VUbK
        GNwlU5CQaObDrf/xSBHe9/ix+JHUQ=; b=BA7wown1WoRRx34hS7mn5MXPqOgCzA
        vULnN5tq+e88S/lgyUvrY3/JybAKd+23i4U2vmq4cYUUp4cWi1U2KZw6zeGVZ9ip
        xltyJN6tf+v9Cw/8wfvnLztCLGIi1oDOVyr5yJzDFIHPP1w0nf8QTcnPpP4f3GTA
        vT1iI3raT6CoChXx2nedCEQWI/K4Em8tPK7dL4Y/WAyTIUdlg3gpEDMm1ud0G84d
        J7QEqwvBtpTsswEDZSjN4uNf+bSIYAe4Was99AvziW1N12WaiOX0Ouk8SXTwUGd5
        48QymV+ZRhjwfje0xtNHu5Fdgo7SrkJJlgSyulB3glFeQwi/jpW4gnrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pUVEwGHg7/VUbKGNwlU5CQaObDrf/xSBHe9/ix+JH
        UQ=; b=c38/FxSJl6KfLIEL5KvZDEk3+ZEtiBZePLPQ/euGhY/Vs9LewGTvzbtZG
        KKTpM7EvrYAP4vg8e3Utex/wzlQHrYAVfRI+YHTYDM1dJtejMoP9cT5mkufQN8W6
        IW8vphiwLBC7xljmere+HP4Y4gZSPrBlcG+YYVtJdplr3fNwKxElCm3EOaLndxKs
        Fvi8Ey1oAGUUNQ/4WCqIqfi/EmhPx8nUIAjVt9GLrCwtCInLOOHtGBUCHj3N+knD
        rVvK2M70MBXmLaNP5GTTF81n6kou44SGqtQy8jk63EOD99vK0WE1uSYU4Sdp0vuT
        3SVVlVKhZ1QrtQwS7I0DIi2ZD+LPw==
X-ME-Sender: <xms:jjdBYjUc29HzGn1iNGnh3jp8wc3x48fw_e8ERnk9HVRd0KfM_pR-Gw>
    <xme:jjdBYrm8dHRQdIDW4H_LEwTisdiEtLh5MyUGvSaMBVA5-Shttwa2NJlS11uhRXAo3
    NZwci_EwahkpNYVCQ>
X-ME-Received: <xmr:jjdBYvboLtckI69dN1eY3Hs9E-OYkltj116M7DQFfc189faWmgNrt-mOfxeTdBdIvciODbBie6SlZ17d0LlLdlUfCJHf-4a8niatvCzpkIsO3nWtHsweOW9_rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:jjdBYuWg8R8Md5GBmT_6dH8J8joYGN2wdF6I5NR4Tp1KeE49IgPytQ>
    <xmx:jjdBYtkDz9UYfSrlDGwbfi7uO0F03qVRKeWx7td0ByayLn0RAizuFw>
    <xmx:jjdBYrc1jEHc6GD2F9whYds080MNHDWQ7rRkHgTUxffg44BzHG3c4g>
    <xmx:jzdBYvngiA-m9rp2jWDZ6zLN2T3lrXPuMg2IteDfgMFHbiDKgDdpyQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 00:20:30 -0400 (EDT)
Subject: Re: [PATCH v2 11/12] ARM: dts: suniv: F1C100: add SPI support
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
References: <20220317162349.739636-1-andre.przywara@arm.com>
 <20220317162349.739636-12-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <1800f538-ba38-f1ff-ff70-59d96de0dfe8@sholland.org>
Date:   Sun, 27 Mar 2022 23:20:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220317162349.739636-12-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/17/22 11:23 AM, Andre Przywara wrote:
> The F1C100 series contains two SPI controllers, and many boards use SPI0
> for a SPI flash, as the BROM is able to boot from that.
> 
> Describe the two controllers in the SoC .dtsi, and also add the PortC
> pins for SPI0, since this is where BROM looks at when trying to boot
> from the commonly used SPI flash.
> 
> The SPI controller seems to be the same as in the H3 chips, but it lacks
> a separate mod clock. The manual says it's connected to AHB directly.
> We don't export that AHB clock directly, but can use the AHB *gate* clock
> as a clock source, since the SPI driver is not supposed to change the AHB
> frequency anyway.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
