Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C746665DE9
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jan 2023 15:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjAKObY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Jan 2023 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbjAKObA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Jan 2023 09:31:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67271DDEE
        for <linux-spi@vger.kernel.org>; Wed, 11 Jan 2023 06:27:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id dw9so14645016pjb.5
        for <linux-spi@vger.kernel.org>; Wed, 11 Jan 2023 06:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JU9uOLBXwDq1mak9/6gC53XS7EEj/Tc1L3e5EpQLvw=;
        b=ZEPKiMp1v5hpz09WX05iwtZsA66nsLujI9EnvCJFlHU1zwuDqjVWPQ//fq/6eXPYvp
         Az919kdBuh62vmWbUxs5kb/lIALWi4LTDTjBW6QBnREucKoG5E620vz5CTRulHQOpaVg
         5lQTHMQnigAlZ6xFF7CBUq4NhesITeSzDDPvLaQyr+II8y2jBcU8hNfaBysV9e+WSWAo
         yfjx7HMBFAD1OEOZXZrqkpFzoMCHBPzqVM5KQJUk4JmzXLmubQhTqlpelnFU9O9+0sXf
         hpWOMC2n6vrozSyyDivoP0U7DJVbq/hRDnnOQlTR+JFyPdLbnSq0/6AryjjoSFkhj1rR
         xxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JU9uOLBXwDq1mak9/6gC53XS7EEj/Tc1L3e5EpQLvw=;
        b=puucNmgaZMedTIOrVVCKOMXWnDqKTbjneZ67P0QV3ujYLIzxqrfg9zRHxcQG56VqBv
         vSGnjTU6QRQHnGDODsokscT8hsnY5GH/rs1KQqFWocaxykWNUgzsrtN0Oz+PVtawT28z
         1ZjoOtWwnpgLs3M0FyL7c3n5V5qq4NeQrsGZlAHqDFVu18ntM5zH51zdIxL6lGVQFMn9
         xN1eReIi/W8Th4s0F7b/YWQQi33Fx6sA3YCPv+IlgL3h2rcxKb1/vUHFG8YrXOUI6Wrt
         T14XxDRtnkjctR4vGP4U9pbcGFm2hAYAvO+VrVyQ6e3WAwTd1SRo6LiqfbSgrTFNSHSl
         K3lA==
X-Gm-Message-State: AFqh2kpBVX6EgAgy9nka+aau6dQUX+qpOVAUgTMd2ikq9sMcJf8z9Q3T
        nbiDtwfG7ivm7w7+YXRxh2bebQDgb/H1NG11og5jXJar
X-Google-Smtp-Source: AMrXdXtAo03Muw66CL/fnZ3L+pqLZC4WV37h/Zou+0ji4csbwMSMk64MrTznSxlbmTIR5yVMKLDzwXQTzc0simoeEZ0=
X-Received: by 2002:a17:902:aa02:b0:193:500:e09 with SMTP id
 be2-20020a170902aa0200b0019305000e09mr2051106plb.168.1673447263063; Wed, 11
 Jan 2023 06:27:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
 <20221219200857.fckuqovt3xt5r352@umbrella>
In-Reply-To: <20221219200857.fckuqovt3xt5r352@umbrella>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 Jan 2023 11:27:31 -0300
Message-ID: <CAOMZO5CyeHW_bNB+ow2=dxWA-6bg2Rm-vY3Wx4LGvu=bJ+fagw@mail.gmail.com>
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

Do you have some patches you share with us so we could try flexspi DMA
operation on i.MX8MM?

Thanks
