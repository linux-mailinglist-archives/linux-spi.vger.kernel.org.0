Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC434552ADF
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiFUGPI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbiFUGPI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:15:08 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE415FFE
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=bqpep5BO3Fgrgfa4SevToaHV4dxvvPs+OL/uN42J6KI=;
        b=rC/AiccRKYHvaVBoO//EqM2revXXiZa2HPQjGxvDUhuoLUGvQwf1X3kBqY7pyFoXWx0GhDQqRS4Zw
         Q7m/keJWHF+5rlXZ23dYeb/aboXs+XEzomP+QOdS7EX/UD9LGkJ9R6sHQ/7xkvhAJt+GxIFTjL9tOl
         Er+foE3auCMT6p/7Uok378tMySlHVypMFivi/V7UxHOD9dUNe4zzfThTeiVpPTlNcDjcRZCtDB71j+
         CJ4rxW493mmJz/oGkixzvwbSXWG77pyJ+jbaNyWni2HstrwUNrY+b+ZXg89SqYVK6YH64vL7wLiGv5
         /4BZ5F0e10LXtdMy0TzeZAtRx1MzqfA==
X-MSG-ID: 7da0ca29-f129-11ec-8a45-0050569d11ae
Date:   Tue, 21 Jun 2022 08:15:04 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <20220621081504.3c4e712c@erd992>
In-Reply-To: <YrC5MX4osVCET0la@sirena.org.uk>
References: <20220615124634.3302867-1-david@protonic.nl>
        <20220615133113.ylwenlzpkv2na25z@pengutronix.de>
        <20220615161356.21bf749d@erd992>
        <YrC5MX4osVCET0la@sirena.org.uk>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 20 Jun 2022 19:15:13 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jun 15, 2022 at 04:13:56PM +0200, David Jander wrote:
> > Marc Kleine-Budde <mkl@pengutronix.de> wrote:  
> 
> > > Which git branch to use as the base?  
> 
> > Sorry, forgot to mention: spi for-next:
> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git  
> 
> > This is because it relies on previous patches that have been applied there.  
> 
> It looks like something changed underneath the series unfortunately -
> I'm getting failures applying even the first patch.  Can you rebase
> please?  It looks good to start trying to throw at CI, ideally we'd get
> more on list review but most of the active work recently has been around
> the MTD stuff which is all about trying to use hardware offload for
> flash operations and therefore should be minimally affected by the
> actual SPI data path.

I just rebased v3 onto current spi-next branch. No other changes.

Best regards,

-- 
David Jander

