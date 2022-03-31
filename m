Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17254EE0D4
	for <lists+linux-spi@lfdr.de>; Thu, 31 Mar 2022 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiCaSpn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Mar 2022 14:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiCaSpn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Mar 2022 14:45:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA45BD15
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 11:43:55 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e22so515537ioe.11
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7MQEcSwfBb3KjcRUg/INs91ABtIOS3JRaH/ug4JzThc=;
        b=k8tj/9tA1rxeIO7URMnVnVqv4nwl+73KSN60nNA7lGdEN2bfUnUUmiUDKpLiXGJ9ki
         CAgv8ANKh9pUd9qYBJM+YEw3glh1HCF/D5pUlPcvForbH027hslt97NfFKK5OnsltrO8
         ByJFFNvOTew6QreOcQhdID6D9ufoVXe81bpfvMPNSr5GsAAsUEGq4MHLZn1WcBMs3u8R
         J0SNR964FYxdeJuqpTEoqyqYUfTTol7P5BtCilO25b8YlCR0tMsT8cw+VhQFz2ylAMfz
         2IyBgoAX+WKAAQ07loKvn2Lu6j7kpivPYdEX8QKSi82bLG/QW2g00pxUQcnZ53Ze02KG
         NaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7MQEcSwfBb3KjcRUg/INs91ABtIOS3JRaH/ug4JzThc=;
        b=cffVAh5dx5vEkGGxmaZBSENyxe+7FzAYqezlReF4Qb0DPFVdt0E2eDlAjsv9Cu5790
         bgrILS8lpfv5vENYvpQ1yuCNBDcabpoxKU4aSMnQfhtvC7Q/A6CEecexYRFUryN+Aex6
         PG8S/b4hP8AH4uaCAbLGvcfUD6OobyzHZs5/OO6v0aSa57CAh9V3S9S0trUo+YCdfIJv
         XepdJbWmSjOwackhipptFXvH02eqYNdVNi/EfsZ/fvgueHCIQRhmMMTcJtKHpsslYJCf
         Z/0yTciy4QljCqMr/txhc4cp8s0saRtQOGpX2zKzle1wxiuH6qBHPpHhwbWsnh/szZF+
         drCA==
X-Gm-Message-State: AOAM533jx1oOVAqQ4qfhke/AH5wpp33Li7/an+tzjElxDhIkCt/FfiZr
        SciUCE1UXNecGfqJkDF4DjKv/h/Nj/LH6usS8mw=
X-Google-Smtp-Source: ABdhPJyDeKGDwEv+xwC7WsUBWArNEeMCIoI7nh/OZJMxXQteynPqIlCiwosLBfx74rOb8+Syd8s6dBxBzpZb34Bshq0=
X-Received: by 2002:a05:6638:240d:b0:323:a741:9243 with SMTP id
 z13-20020a056638240d00b00323a7419243mr2694700jat.167.1648752234729; Thu, 31
 Mar 2022 11:43:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:c706:0:0:0:0:0 with HTTP; Thu, 31 Mar 2022 11:43:54
 -0700 (PDT)
Reply-To: jessicaum734@gmail.com
From:   Jessica U Meir <jessicaumeir94@gmail.com>
Date:   Thu, 31 Mar 2022 18:43:54 +0000
Message-ID: <CAK=1esCkjeUyF5uJMdHVY1oAHBwzu8U1bWNTvJOqYuQKxT94pw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I also wrote you a previous message 2 days ago but no response from you, why?
