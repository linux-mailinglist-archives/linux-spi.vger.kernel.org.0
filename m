Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB955B63DE
	for <lists+linux-spi@lfdr.de>; Tue, 13 Sep 2022 00:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILW7m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Sep 2022 18:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiILW7l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Sep 2022 18:59:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9BB2AD0
        for <linux-spi@vger.kernel.org>; Mon, 12 Sep 2022 15:59:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bt10so17309634lfb.1
        for <linux-spi@vger.kernel.org>; Mon, 12 Sep 2022 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ff0jwgYzIwDKQF9NeTWDm4/qRAN2yKdH9EDPZb6DaxI=;
        b=Gvt+/OuNvwT89DqH2Q/aw6WknXHIdKBGVtnROQCsH1Ppkb5AEQkcOeX1CIRQ0QcKpS
         mHiA/NqLhM0RIIsLxHoIgGe+C1pKzdainu9jkIwQ2yPuV9xYQcoanD7P1HyphfFkJPph
         R6CG7fcSWdyYl7WmzYQaeWzZ4JyyCOehFolF2eWRU+43YAYziS6nUQkEWabEQSMirdK+
         +3F919nipsa/5rjayEZoIVwrNWGkX1gADwmVpJhbUxYUw1/RtNtaOgbGzqZFPPkSmbDy
         dq+lZi4TfZspEGIajnV++sZ0EksH2PGLk/q4htBM4wxKU/WlZH47ewgFEKW8jc5uI2Pl
         nppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ff0jwgYzIwDKQF9NeTWDm4/qRAN2yKdH9EDPZb6DaxI=;
        b=2YGocCdBUZYmRZCrPnFB7PeK35lKonHTX7JFGqZGXznmGl+SKnbVIju2EpLtqG2wcV
         LNmzWsvtgGPkr4wVjs/b8R2RuI8YFTM3+zxIvW1+s7dS9Piij2uprJwIljRSEY5crRox
         xeVseAnU/nOem7zwdKt29DZuTiNMWjMiUpoaeRCzjOot0zxFX1+wDOgwaoS4c9LK/Zu3
         QQ2Bk/wUIbCHexgp+doIN4jVL5lXjpwPhJOKNNaRyTGEs47XnjLn5VWZ3GdiIFvp3GvW
         uB7csFM0HuezshMSC1ahV8b9f548bcZyLISC6H2vEWN7dkP2xekylh+MHzyKMle397E/
         PXSQ==
X-Gm-Message-State: ACgBeo1k/l1J/KuNZH3fhRKei5AUVFuo5+vkPVWzhTA5wJZ73gIDx9cL
        3kTIIkCgSb5fqbAFAy1uemOLaPDyjS0=
X-Google-Smtp-Source: AA6agR42t2XCzY2b1338RjsI/bSvKctQdL2itr9z3Zbtnv0ZT17EaQu5ZICfQr4VoNZc6AHasdroLA==
X-Received: by 2002:a05:6512:c1c:b0:499:acb9:5788 with SMTP id z28-20020a0565120c1c00b00499acb95788mr4331555lfu.347.1663023577021;
        Mon, 12 Sep 2022 15:59:37 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id z18-20020a056512371200b0049a0832ffc9sm988119lfr.211.2022.09.12.15.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:59:36 -0700 (PDT)
Date:   Tue, 13 Sep 2022 01:59:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Designware dw/dwc driver and qSPI?
Message-ID: <20220912225932.zjxfkf7352byo6t5@mobilestation>
References: <10ff3268ca3e734b215d6a2b0bd5e1de38d0917d.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ff3268ca3e734b215d6a2b0bd5e1de38d0917d.camel@infinera.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 12, 2022 at 03:44:58PM +0000, Joakim Tjernlund wrote:

> Trying to figure out if drivers/spi/spi-dw* supports qSPI as well?

No, it doesn't.

> I don't see qSPI mentioned in these files but I am not really sure. Anyone know?

You can find a brand new patchset with the eSPI feature support being
added to the DW SSI driver here:
https://lore.kernel.org/linux-spi/20220802175755.6530-1-sudip.mukherjee@sifive.com/
but the series is still on review.

-Sergey

> 
>  Jocke
