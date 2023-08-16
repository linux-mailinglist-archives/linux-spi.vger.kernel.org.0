Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F477DEA6
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjHPK32 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbjHPK3Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:29:16 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65B212E
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:29:11 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d650a22abd7so5809397276.3
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181750; x=1692786550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAIEilkW7Y8BODeOBl3F0i2XBSDmi1tZr5wyI94M3xM=;
        b=DiqOqb47xTPcDK0KHJLWD35S90Bigkq3eWx1KnSYGHoL8GNMjlbpET4C/ZLTAJdjzM
         p0ciAjNteL7K3nHrk6xZxpd4sTwTAxohTY3XGBglOsHOULLlMc4wuWOQ/8uvkRaworKD
         wpbWr6nKxRVv09tTm9NlFIztw/rfqPa/w2n2X8WLECOSTcG2cET/ZVhscaO0uzpv/fa1
         7R7tA4Wvg+ticQZjWMUgudaYajwP8rK65Q6nvbRw81ZgpIe8jT3JWUxtgY7AE8ecIO1r
         joaqrLJwsxsMg2+c5KOpTNA8yr+W22BGqfgY2jHYjouMpZlzYRp0pjn3x1sVE8TM1zdr
         RUpQ==
X-Gm-Message-State: AOJu0YxLXMcQ/d3HPUCRxYmmEPosqK78BBcP87tZa29OPtXXDJF6iPaB
        cMcEvbAm52502P/qkWm1rAMPi+ZAeyEfuA==
X-Google-Smtp-Source: AGHT+IF0j/0vVzqmjE5n/Z4pSB61qN+Owl/78yPMibDrWhmqfoTXY1Md9rqGzxtkmbV9s7ern6+pPw==
X-Received: by 2002:a25:c588:0:b0:cfe:8cbf:5d28 with SMTP id v130-20020a25c588000000b00cfe8cbf5d28mr1260040ybe.31.1692181749983;
        Wed, 16 Aug 2023 03:29:09 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id c201-20020a25c0d2000000b00d679ae188a6sm2631858ybf.37.2023.08.16.03.29.09
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:29:09 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso6122152276.0
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:29:09 -0700 (PDT)
X-Received: by 2002:a25:b08b:0:b0:d4b:cb62:9490 with SMTP id
 f11-20020a25b08b000000b00d4bcb629490mr1370675ybj.37.1692181749347; Wed, 16
 Aug 2023 03:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-15-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-15-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:28:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvvXvF2EoKEhiso6VcbmTKydQE=iP_bnwuOcQuYVQktQ@mail.gmail.com>
Message-ID: <CAMuHMdVvvXvF2EoKEhiso6VcbmTKydQE=iP_bnwuOcQuYVQktQ@mail.gmail.com>
Subject: Re: [PATCH -next 14/24] spi: rpc-if: switch to use devm_spi_alloc_host()
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

On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
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
