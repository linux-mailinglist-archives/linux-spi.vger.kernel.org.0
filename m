Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E756652054
	for <lists+linux-spi@lfdr.de>; Tue, 20 Dec 2022 13:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiLTMXi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Dec 2022 07:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiLTMXh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Dec 2022 07:23:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D38910B
        for <linux-spi@vger.kernel.org>; Tue, 20 Dec 2022 04:23:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a9so12078258pld.7
        for <linux-spi@vger.kernel.org>; Tue, 20 Dec 2022 04:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7BInz5tw2YlsEDkaeOiv9a4D/hCSWDF1IAW+8+YvYhA=;
        b=E8TY36LhjOShuS57WDeYRUyUe46RsCBmHiX2G8MKcOM+pjQ1lY0K1JhYmGSuBlEPXF
         bi7n65xjvmMMg6IYX3RzKamPN+Iw1NsfZ7rbVrfKSjOq3F7WpoobmvtG7hCysfdUUcHy
         zCoAMS/fmSrAsHuFeJHKHHzTYCX+34acWyaG+GJ/WIOfTQQYqFuufjV49G380GkFmWCt
         SnaAAvYhBF1sP5Oi2Z4QXix1tGNK/509OC218wdo5Z4jo0XH/PEoh/0wSvAZWV2aIbI7
         gus6J3ZjZM09j0j4MuWDfqalABEF1KzGT/khnVLpCKox9cDnwDhIXVLE8dnpbPo6Ifq+
         UfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BInz5tw2YlsEDkaeOiv9a4D/hCSWDF1IAW+8+YvYhA=;
        b=HMQt6CknwL0KsnwWL6prIIGNmAZxPbSxyezvYntZtG4+pfwYSh2dhI38SuHp398aVp
         v9eiyOJnfOjLaRFsK5wg45vg5FHy7Ua25iKgiitGOt+rtMIyvim18PbQ0ywTEffh6WSP
         Pg2iG5I81u5mpxoG0j9aAEQoodbOJUiPhLW/IF6AWdzL1LUTUalJRBm0+S5hcUtmEqPT
         ekrMn7oHICrU9tShqiC5oQOw3Ovz7MDBQgd8toAp2ZO5eDR8c+Ph4lWeP0yJtLcgWsas
         d5iiHBDyU6WMATsY2Jfq0H2R3Sf1HJnRSvTovMOZ07O17xD7uS2uFoBzqiLtf8MCdoJn
         dWzg==
X-Gm-Message-State: ANoB5pnxsH8KixBL3hkWpRKYq7MnXowSVp4RD1K7H6322O24b7U0mu61
        eCb9vD7RwEPCi3/ZWGRiiWiOzLh6dsc1m0eDzCE=
X-Google-Smtp-Source: AA0mqf7YG3VB161DlUWbDDBOHb8fHaNfE+3V37CxmSOhGfSdQEAC39woeFKC/c3strgJabluyVebqrsrttE8ztIdYrw=
X-Received: by 2002:a17:902:8a98:b0:189:d081:1ebb with SMTP id
 p24-20020a1709028a9800b00189d0811ebbmr22113101plo.130.1671539016655; Tue, 20
 Dec 2022 04:23:36 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
 <20221219200857.fckuqovt3xt5r352@umbrella>
In-Reply-To: <20221219200857.fckuqovt3xt5r352@umbrella>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 20 Dec 2022 09:23:25 -0300
Message-ID: <CAOMZO5A2OJLnLFyMrVJLVvbHiVagnkgQraZrNZZ1gkHvgfz1rg@mail.gmail.com>
Subject: Re: DMA support for FlexSPI driver
To:     Han Xu <han.xu@nxp.com>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Michael Walle <michael@walle.cc>,
        linux-spi <linux-spi@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Han Xu,

On Mon, Dec 19, 2022 at 5:09 PM Han Xu <han.xu@nxp.com> wrote:

> We are working on that, both flexspi driver and sdma driver need to be updated,
> and will upstream all once done.

Thanks for your response.

Please keep me on Cc when the patches for flexspi DMA support become available.

Thanks a lot,

Fabio Estevam
