Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED777FAE3
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352317AbjHQPgN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 17 Aug 2023 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353234AbjHQPf5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 11:35:57 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D159A2D6D
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:35:56 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58439daf39fso82368877b3.1
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286556; x=1692891356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDYEzZ2iPRHt3TB4pTbESnNextfKAV8C/RMNbHUwb7o=;
        b=HPwvbZF4OYYByQSLjVjFMr6A0S/6II00jiLIyr677IVR7xHRBWhKUtf7fao7ZznBnp
         szw6KJFqZWoE4s4Zy8/mzcgel2AQNW+MB6dT95ybPr0eBb8yuKCKazRd48VlOOe9bST5
         /sz197ceHEDQy50YcbU/k9CyQS6nC9svh/x82iWoVYtYNff6P5RWP3PXpoIND0fra198
         3+xIGM+bp25HbpU30IQFbK9raV/w38BOyH8xEUxMwLv5Ox1ah233MwOemEs2T6hUcGSa
         1P5SUbIwlDBR4gS6bOXKbOwvbCw1vF/aly26EOq2vpapViy9hGBoXRnwYiYQrseh+o8/
         aHfw==
X-Gm-Message-State: AOJu0YwnzpbwgZBsa+mdzv3GxS8cLdJoGdVJ9nrfBEGZosWkh6jav5bp
        QTQ8eC1i6vCud1cz86gXo+0hLTuULmz6HQ==
X-Google-Smtp-Source: AGHT+IGjD+UIdeBnqq5ObGS+YTgeOy9XNXRwAi2FtD9zTMFRBKZEjdOgAqTp07oa46qW93/e/PaYxA==
X-Received: by 2002:a81:a204:0:b0:586:a597:a002 with SMTP id w4-20020a81a204000000b00586a597a002mr4854679ywg.6.1692286555766;
        Thu, 17 Aug 2023 08:35:55 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id l187-20020a0de2c4000000b00583d1fa1fccsm4679441ywe.0.2023.08.17.08.35.54
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:35:54 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d72fca0043aso918197276.1
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:35:54 -0700 (PDT)
X-Received: by 2002:a25:941:0:b0:d0a:da40:638e with SMTP id
 u1-20020a250941000000b00d0ada40638emr5308189ybm.12.1692286554525; Thu, 17 Aug
 2023 08:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230817050332.1274751-1-yangyingliang@huawei.com> <20230817050332.1274751-16-yangyingliang@huawei.com>
In-Reply-To: <20230817050332.1274751-16-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 17:35:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW86YNSNsQrShJmg3HVc-mG4rEtAWgvqin+n9-99NitKw@mail.gmail.com>
Message-ID: <CAMuHMdW86YNSNsQrShJmg3HVc-mG4rEtAWgvqin+n9-99NitKw@mail.gmail.com>
Subject: Re: [PATCH -next v2 15/23] spi: rzv2m-csi: switch to use devm_spi_alloc_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 17, 2023 at 7:07 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Switch to use modern name function devm_spi_alloc_host().
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
