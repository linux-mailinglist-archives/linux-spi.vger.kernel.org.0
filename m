Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7544B77FB24
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjHQPsb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 17 Aug 2023 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353321AbjHQPsG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 11:48:06 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5109430D4
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:48:05 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so119604691fa.3
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692287282; x=1692892082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWKv3WNprTsyhMmNWe6+SPIfgcmLsrXL1qZKcD6X9mM=;
        b=ElXxj+HU2gojVx9k57TYZ4InDxyMjSTc7bhG2hKDr2stq2/28iAi+rvhz0VMk+f86w
         g6RZCFWjMwuX5sIwG8qbJoS25wbMk3nS7l7XUR6hEUPe6g9vWXx0+b6GPYMV4XKtKJda
         ZlrT8D3bfXq3JZczA5nOZ0vazxYKegkqhx6+USn1IPK7/Ovuas69CLYG5f/ojCqvd3es
         W3shBCRfdXkUOYwUkQ5n2DvnVrJeGTd7dxXUVlaefqKdFHV2Vx32d3lWBzvEn34549fy
         b3AXia+xxeA4rm8U/VH0cuzhQO5SX+t7r8HYtd2gqjkxZEprEEGHcRM2u+ce9vJv0AjW
         e33Q==
X-Gm-Message-State: AOJu0YyDXGsAu5INfxEDmz4lWst2YvUVbV20UOTKzhiJDWR3aypRs6uD
        7HZoDOL1lxLfVfB+xIxhgUkHByYohGMptoYG
X-Google-Smtp-Source: AGHT+IHuyohAWHEaMeWWnvEjS0HMJtjCYSZ12eAXFgxPDay9cvJOcgakE6m5V8ZBOLjD2VcP0r3Fdg==
X-Received: by 2002:a2e:9c50:0:b0:2b6:eefc:3e4f with SMTP id t16-20020a2e9c50000000b002b6eefc3e4fmr4366631ljj.21.1692287281775;
        Thu, 17 Aug 2023 08:48:01 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b13-20020a2e848d000000b002b6ad323248sm4098941ljh.10.2023.08.17.08.48.01
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:48:01 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so119603781fa.3
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:48:01 -0700 (PDT)
X-Received: by 2002:a2e:9ac6:0:b0:2b6:a6e7:5afa with SMTP id
 p6-20020a2e9ac6000000b002b6a6e75afamr4770261ljj.12.1692287281145; Thu, 17 Aug
 2023 08:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230817050332.1274751-1-yangyingliang@huawei.com> <20230817050332.1274751-19-yangyingliang@huawei.com>
In-Reply-To: <20230817050332.1274751-19-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 17:47:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxFGDpF6+4di_2ck3M8HXMSfVLWQhgULmQy1Sax4BYZA@mail.gmail.com>
Message-ID: <CAMuHMdXxFGDpF6+4di_2ck3M8HXMSfVLWQhgULmQy1Sax4BYZA@mail.gmail.com>
Subject: Re: [PATCH -next v2 18/23] spi: sh-hspi: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 17, 2023 at 7:07 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Change legacy name master to modern name host.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
