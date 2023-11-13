Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8807E9F1D
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKMOrq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 09:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKMOrp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 09:47:45 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA26D68;
        Mon, 13 Nov 2023 06:47:42 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1CD08A4D;
        Mon, 13 Nov 2023 15:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699886861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmhwlB5vQ8e49oOV+d3Bk02ta3chZh7tmTvgbMcd6qQ=;
        b=a8D6HYdDVj3OEfupuS24Mmo9fY7lfHsWhSL7xabbh97kJZsNz6ZYbhZfMrw5PMnmeh3DdO
        SNJb9FcJsbEpl7+2tLHMZWsf4lMTL5X5YSYFATT1+RkK5iZPlM45S1hJPGeaeq4GmynkBv
        BAXqY/boq3fhjIU8NJu1uhcNC0dYMFgTjpMDNE5RBg2Ro/Kqdxr0losj/Y8y4jTRWRd619
        Zci5hOKLetVB2l1FYm7SBENo+yjZa14EJeSZpFBw/QZi/7SYt0ezv88yxBK5BaoPCbR1w7
        cyd/64g8SBSKozkPSC80Eva9P9ZFG/iVHJSTF9ClQdKHSxODLDtpsl4YcIXfvw==
MIME-Version: 1.0
Date:   Mon, 13 Nov 2023 15:47:40 +0100
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
In-Reply-To: <4c6674a6717152fc1a244d123a2db896@walle.cc>
References: <20231108171149.258656-1-biju.das.jz@bp.renesas.com>
 <877590a5e3f8c32ec0a032385049a563@walle.cc>
 <TYVPR01MB11279E535835F2998335F770A86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <b9831be88008b9f9960d1d79cd0e5a3a@walle.cc>
 <TYVPR01MB11279575676708170F3B3270D86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <f88759f98e865e68da5481fcbb969c47@walle.cc>
 <TYCPR01MB112699263B2EC0EC229746D3786AFA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <dcfa2cab21fc85bb9b2b0c1ceb754a1a@walle.cc>
 <TYCPR01MB1126990A40D40D8786CABFAAA86ACA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <4c6674a6717152fc1a244d123a2db896@walle.cc>
Message-ID: <e8ed909b39b5a7de46a07d2b57c0393a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Maybe
> it will already drive IO3 high by default?! (and esp. what the bootROM 
> is doing
> if that SoC is able to load the first stage bootloader from NOR).

I just had another look at your Renesas SoC and indeed, the register 
default is
to set IO3 high if not used. Mh. I still think 3,3,3,3 is the saner 
default.
But I might be wrong. Hard to tell, as the sample size is just Micron 
and Atmel
for now. And it's still unclear to me why the Atmel isn't working with 
3,3,3,1.

-michael
