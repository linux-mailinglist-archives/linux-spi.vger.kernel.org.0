Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610167E9F25
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjKMOs4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 09:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKMOs4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 09:48:56 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4991A5;
        Mon, 13 Nov 2023 06:48:53 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9CBAAA55;
        Mon, 13 Nov 2023 15:48:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699886931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OyJ9g1UzIPr8DqkcWgeEx8+hn1JF3+X7EjEv6nEj+8=;
        b=frP2F3Nb3Xd9m6vFKnAxazw66BRbcrnazEs8fJuTVeZXskhg033sbOeXgQpkg4wzffEtKI
        gTxZbXgHOC4wO9guYE5wZJfBeuE+KmoBRTn+pbvRcj2+Ly9bbVPYWJ8Sb7lA4C0BALiM4l
        /vYLbbDG6PBINdsDjffengMZpHgajaEsC2K8TFbz7AN9PDrz4bbs4dhsXj4YwXd/fh8k8a
        lYUEzH4Ie0F2KxGpXQeakAx2sBw+OGKaKrpdx/dAmvtRM4JIZIk7IWfs/1JrPBpYbvnhAS
        si9mNJwQtkbL1pKkTzIDxZmO+jbxN55oUdvG/2CfjPutFxRpROsWb1t/Vie7sg==
MIME-Version: 1.0
Date:   Mon, 13 Nov 2023 15:48:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "biju.das.au" <biju.das.au@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Add set_iofv() callback
In-Reply-To: <TYVPR01MB11279DF8A78E6C15CB0E6209E86B3A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231108171149.258656-1-biju.das.jz@bp.renesas.com>
 <877590a5e3f8c32ec0a032385049a563@walle.cc>
 <TYVPR01MB11279E535835F2998335F770A86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <b9831be88008b9f9960d1d79cd0e5a3a@walle.cc>
 <TYVPR01MB11279575676708170F3B3270D86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <f88759f98e865e68da5481fcbb969c47@walle.cc>
 <TYCPR01MB112699263B2EC0EC229746D3786AFA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <dcfa2cab21fc85bb9b2b0c1ceb754a1a@walle.cc>
 <TYCPR01MB11269C639CB7AA480E388360B86AEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB1126988E1A0741B99DB8DE59C86ADA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <3a9184e1e91689757a5b680e699ce02d@walle.cc>
 <TYVPR01MB11279DF8A78E6C15CB0E6209E86B3A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
Message-ID: <c0928bb386aa3d8ad8d1966fa5060efa@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

> After that I will send a patch using IOFV {3,3,3,3} for both micron and 
> Adesto flash.

Just to be clear, that will just touch the spi controller as a global 
default, right?
That shouldn't go through spi-nor. Otherwise I'd prefer to use fix (2) 
from my previous
mail.

-michael
