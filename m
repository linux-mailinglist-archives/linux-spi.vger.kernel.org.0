Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A54D581D
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 03:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiCKC0t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 21:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243490AbiCKC0r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 21:26:47 -0500
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 18:25:45 PST
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E91A616E
        for <linux-spi@vger.kernel.org>; Thu, 10 Mar 2022 18:25:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A99785C01D7;
        Thu, 10 Mar 2022 21:20:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Mar 2022 21:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=VaT3pxot9g5Z0z
        nqn/4P4m9tGg8Kgve6dIgEH+GSsDY=; b=c1JBDvpgFPlaeZTszV7UGRyh8S2NjC
        6sEMyBHPKesGgJjUjU61rYHnAWwYBSRhIWpvcKaBJsB8Ed9f/vDoQ0Mfcwn6ii5A
        MMPQ2MC18yRADliZ1/8Z2qIC0/o/73sZcobS96HTy8CZqtjTrYvgu0RmhYLpzGcH
        81oCzC84ESje5ySiiEpId2g1zChMQo5AtVEkmvzQiIRRihi5TMYrCHllEh+hj/cF
        5foiVKPL1mN4xA+vrPWxHXiEvJN/qbwV9K/oYnZj3bwH966JYypP3yVO0nIB5/1u
        jwSSXVyUT9I6yWguap8gvFZMgx8lPOttuhHoAdnhXEDSZ04smbiD9Vdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=VaT3pxot9g5Z0znqn/4P4m9tGg8Kgve6dIgEH+GSs
        DY=; b=Z3niQzn0nDkRgp+6zy4wb0trcNr4NLEYJU3rldoy0Zr3PMOaw8GneciQs
        mG8VNqCXi1TiP9LC2evCnVY4nCrYGcdRBP5lTIvYsGAaCmtr14nkM8rP9rjuvS1N
        0LEG4jH+rq/n7rpCQzoRZ+vaQXZ02HW3XJg1S1+N8ZZkMfzK0UO3J2CzpgPWxWH9
        R9DV1PxJfI4U73UWbDXget2EqhB/XVFCKigQOZV3zWHXIKqTKMHpo+ciQwx+n2D8
        U8Ll4wr2hjhkWaJLarOlLQNyEjesfzX6ZFkTOEwIzgg7boBUENOpkKpbDbRgxqT4
        p1+X5cQaMqhTspqqN1Xbk8JzLWG8Q==
X-ME-Sender: <xms:17EqYpiP4iwS9UPBvddr7vWnAEtN4EZ8Ysh14sPr0vQNu-oSXNnU8A>
    <xme:17EqYuDPjyFdWRebyaVeriQBkqBoSP2g7tUjxPduG8FaqWCGmJ1cWpbOdfMLrAYc5
    OxLIViNdhQLrWubxg>
X-ME-Received: <xmr:17EqYpEa31hi9are-bzUTIWXgMKhK5p8uHrUmYo4K6JiJFdqopk9d4MUOm49Ssb_zvbf7VfbuJCPZKT-gkYW_XiT7nbbxKgBGTRzewnNYzPjc4yWmqve4r_DhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:17EqYuQBbMm-L6xdLC1dUXZ7ARDnkaPyOj84iFQ6qRQ4z4ZtbPePUA>
    <xmx:17EqYmxqI3-G6XEuvlDR9wY47p3ko2bwg47e2FUPZHjG7aAE5wFlxQ>
    <xmx:17EqYk70JzhrqVxn3zA8SdAiZdP8qzh-hyULriknL_Fl1tvecKnTCQ>
    <xmx:17EqYqhMsJJm5Co2_7TQzt7WoKELl2wqokXDKGjikTQlteGPW-tl-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 21:20:04 -0500 (EST)
Subject: Re: [PATCH 12/14] ARM: dts: suniv: licheepi-nano: add SPI flash
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
References: <20220307143421.1106209-1-andre.przywara@arm.com>
 <20220307143421.1106209-13-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <4fc0ea6a-f08d-3032-fc8b-373b80edc5cb@sholland.org>
Date:   Thu, 10 Mar 2022 20:20:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220307143421.1106209-13-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/7/22 8:34 AM, Andre Przywara wrote:
> Most LicheePi Nano boards come with soldered SPI flash, so enable SPI0
> in the .dts and describe the flash chip. There is evidence of different
> flash chips used, also of boards with no flash chip soldered, but the
> Winbond 16MiB model is the most common, so use that for the compatible
> string.  The actual flash chip model will be auto-detected at runtime
> anyway.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
