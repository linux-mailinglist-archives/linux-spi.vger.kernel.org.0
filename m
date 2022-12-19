Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEED6510E7
	for <lists+linux-spi@lfdr.de>; Mon, 19 Dec 2022 18:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiLSRIP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Dec 2022 12:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSRIO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Dec 2022 12:08:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399DDEAD
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 09:08:13 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso9486906pjh.1
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dT83l1vM+ixLZi6+SPuuupUbVSY5XbbzlKMCqBT+lzQ=;
        b=XybBkcOyPc3rS3i/MeyxETj5jE30evR7BOJtUM7UuSPVW5DYZQlBS6jL3bGYqKc+UW
         hBC9bWTDCp7plw4zFGuz1ssluyV+TA3danUhGBgKjeVfw2Zhr+jEOKVgkWV5o+jVHlpA
         k5dvaqapZ23DvkUdA03rrTA4C9azqGvawbTSt7m2pPVfrGA8/G1XAqijBynH8CrghkVd
         G6lkuQq+0qRK9rxFpL+O6EgPUxLtNFkngcDDFyj+pf8vKo4Pybea5LhZ6QwnwmpIwN0c
         Q78B0UR7xHKvyZd4nV0RYEJvJyBOw7IUQbXmiP+/wC03bJPaBTYSuQhdy2X9IIFFqBXw
         wPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dT83l1vM+ixLZi6+SPuuupUbVSY5XbbzlKMCqBT+lzQ=;
        b=Cwjqa0T/cL3c0zCM2vGJezon7oaEbRLv+Zr7vT0X7GN2N6G7D/oOP5AUldF4t0Nczg
         GrNtuyQwDNKGjBiSkPPJ58RrEVpx33fQ0lQd19otiBgOZC4UsJP75X9FtuweYPT6cod3
         3OxlDfeFoGc2zvKilv0Wu3IG6/iD4xJt6Rv2NPFEqQg1xekGMs1v0h1s7obgFASd6zJ4
         W3r+XPux+NGwlJyDK4uBlha9sbBl00KYIqKTHlId7Ps1O3YDW8DcHmnpZaV0jpMWN5sg
         BiAUDexH3hYb9pmbnq1TVZbL54NZwDg0M9l8K9f4jP4r2fVZL6UVtu6juayfl8uMaL5h
         ciNQ==
X-Gm-Message-State: AFqh2koOA/etCBQCvZ3/9Qyrd4RdYMFMu9/xw3SjzjYQEzhULgrMQ5TF
        R4KaQqjkMO5/LIzZAqGaP6E4pNinZbacFHOQS4s=
X-Google-Smtp-Source: AMrXdXuV/u8BJgPtqkiTfhieSsJx/rWPjAA3FPwQgpT+ormvZ5R+us+OsFB1Qwg1iRevBVmjmPphV4tjlfR4+cDZvDQ=
X-Received: by 2002:a17:90b:4391:b0:219:720c:86aa with SMTP id
 in17-20020a17090b439100b00219720c86aamr1146703pjb.172.1671469693372; Mon, 19
 Dec 2022 09:08:13 -0800 (PST)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 19 Dec 2022 14:08:02 -0300
Message-ID: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
Subject: DMA support for FlexSPI driver
To:     Han Xu <han.xu@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
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

Hi,

Currently, there is no DMA support for the drivers/spi/spi-nxp-fspi.c driver.

Is there a technical reason that prevents DMA to be used on this
driver with the i.MX8MM?

Also checked the NXP vendor driver, but DMA support is also missing.

Does anyone know more about the reason for this?

Thanks,

Fabio Estevam
