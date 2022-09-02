Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACC45AA81C
	for <lists+linux-spi@lfdr.de>; Fri,  2 Sep 2022 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiIBGiQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Sep 2022 02:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIBGiP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Sep 2022 02:38:15 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2DB0885
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=aMm9uMSH+XyHapJCfAPq3sYUvc7NxP2XBuGy0Zz8mJU=;
        b=WGCk+V+mpUE06EgLqYE3HsXMvBAlAyumBALbJpgVujYmjwwK2nrybuy/1oG/cpNX0vNfGxRzo+FNe
         oUOa+Sm6HLZuihe8hTI/jQw5tlgBUProkRra3J/tzyEfAMKc8XV52CV/7J4dsRvXv52EfY+2AGbj5S
         o2n/ZJcsjNVp25U1IsLVgRZl2TUL7cEqcZ8R1KylTEW4zsq0Dp4fbHvZ411qjMKBNlcwkRn+MFgk2J
         kXN3gCgxTJHdOiC5XsCvosPIWZYMCfX4APm+mtEhLiTxzF/XEfBtwdj2o3iXbUkJVXAIoGw8VwyffF
         VNqf3OCXsyX7g5P4H4AOdI3pSbp/8tQ==
X-MSG-ID: cf70a332-2a89-11ed-9051-0050569d2c73
Date:   Fri, 2 Sep 2022 08:38:09 +0200
From:   David Jander <david@protonic.nl>
To:     Casper Andersson <casper.casan@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <20220902083809.1e41862b@erd992>
In-Reply-To: <20220901151654.naqa32vckuzvuoac@wse-c0155>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
        <20220829105613.476622d2@erd992>
        <Yw+HTj98V1ToLWIL@sirena.org.uk>
        <YxBX4bXG02E4lSUW@axis.com>
        <20220901130222.587f4932@erd992>
        <20220901151654.naqa32vckuzvuoac@wse-c0155>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 1 Sep 2022 17:16:54 +0200
Casper Andersson <casper.casan@gmail.com> wrote:

> Thanks for the help and fixes. I did some testing with your patches. I
> saw you already submitted the patches, but for reference here's my
> results.
> 
> David's initial fix (changing async->sync):
> no issues
>
> Mark's fix:
> no issues
> 
> David's second fix:
> Issue still occurs. But does not cause any problems and together with
> Mark's fix it works fine.

Thanks a lot for reporting. Happy to know it worked.

Best regards,

-- 
David Jander
