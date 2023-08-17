Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6977FAD9
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352323AbjHQPfl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 17 Aug 2023 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352316AbjHQPfL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 11:35:11 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B430C5
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:35:10 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56c711a889dso13488eaf.0
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286509; x=1692891309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uTTqVXyzEikYyNZLzYrRZYwgqgokcx2EIByeaywONM=;
        b=U0pjMJ5p5HCZNUiO4MNJ6LalWHgE0YDDKQtV15hB869dh89W3EhtYyCJj1DvX5rVaS
         A4p6I74/1wOi0DvrlHGyaqxoB6/4DfkTp/h0Do9VZiFteY6ABjgjek876NNPeMpjEpc5
         2d77073YYW7Yk3v0bZpzzMIVsEla1dK6vsFDvzS8w4YB4r6HHaEeWAXhTldCeg4hKr8+
         eV0RB5AEUozU9Q7EhBO3nviiEa5E1PVPiowG9CkVcqhE4pARV2sZUfbRQYCp7a2Qpw9t
         3M6HBpy2I0zOnUkmMkIne+bnQkXU3oGJJzc79nax7tWaX6E6nz4poLe2hgr5B8aIoiOD
         czPQ==
X-Gm-Message-State: AOJu0Yy2CfeCvMWuESPcyhRAqWlk2kU0uQE7jmkkclaJXPXqC6D3YTUr
        VGMfJ2/QxgEeWzMk1jp90dPBSX7Vfv436g==
X-Google-Smtp-Source: AGHT+IHFefAy+n6GYS4VylU5W8RHCmYokZWJvMgF+bcTkN5z6XFlx0gugbqSml5XTP7J+wnUNds8PQ==
X-Received: by 2002:a05:6358:41a2:b0:13a:4f34:8063 with SMTP id w34-20020a05635841a200b0013a4f348063mr7033305rwc.32.1692286509275;
        Thu, 17 Aug 2023 08:35:09 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id x136-20020a0dd58e000000b0058c4e33b2d6sm2059566ywd.90.2023.08.17.08.35.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:35:08 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d6b0c2cca0aso20459276.0
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:35:08 -0700 (PDT)
X-Received: by 2002:a25:3758:0:b0:d3b:a164:aacf with SMTP id
 e85-20020a253758000000b00d3ba164aacfmr4937447yba.44.1692286508328; Thu, 17
 Aug 2023 08:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817050332.1274751-1-yangyingliang@huawei.com> <20230817050332.1274751-15-yangyingliang@huawei.com>
In-Reply-To: <20230817050332.1274751-15-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 17:34:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXCLu-tq9QAzkPcJtuGynD3WCXTmDhSjjULaPKC65Duw@mail.gmail.com>
Message-ID: <CAMuHMdUXCLu-tq9QAzkPcJtuGynD3WCXTmDhSjjULaPKC65Duw@mail.gmail.com>
Subject: Re: [PATCH -next v2 14/23] spi: rspi: switch to use spi_alloc_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 17, 2023 at 7:07 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Switch to use modern name function spi_alloc_host().
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
