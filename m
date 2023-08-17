Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93277FB04
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353264AbjHQPlf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 17 Aug 2023 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353290AbjHQPlR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 11:41:17 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0B30DA
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:41:16 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso12294189e87.2
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286874; x=1692891674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7EichZtVY58OabLWJcHXMxhb7mSwDeBhM3Nr7lF2lU=;
        b=TlWw4a1zxoXHgEcxBh/BTlPpKiUYNIRrMDizVIHAruRrI0q4TwSxNXOKSEOctANJyw
         dm5ZDQ0eMUB81ydIafWRgBIQqqrnxE9vHKs8LX+xB/T0o1Bna6lIFM/deNEY+L70+Rvq
         BolO5ONMMj1GcO2ibikSZdxX9odb4ZKjCryYJ14/4Bm+ovgolruiJ/HxR73xMibcs+rJ
         MmcJ5+fhLBUFskQUj1KKzfh9o379RVmpRwLOEJbov81SLTFGYk8Bs3Yq3JKLq21UG5Gt
         snxvEjk7MlkFqfQdXLNAZ3nYamOfF62BUyrrJPvmTfBl0tFt1L9C6ECxFwD+H6UQdVZe
         1N9w==
X-Gm-Message-State: AOJu0Ywl2gBIw5QkieeGGbN9bwVNQH+DUh1CGiftna8SxVdjTUlQuD90
        I3h/dQTv9lc0fnB4f57tFFSolCrILrowN4iY
X-Google-Smtp-Source: AGHT+IEvU6DePbhSJ377rZ2XwCuBxsU1WcmVH78cI2phdue6ZdLpjwO7Qqf8xhCN6zRNwuhEf7jFrQ==
X-Received: by 2002:a05:6512:3112:b0:4fb:8c52:611 with SMTP id n18-20020a056512311200b004fb8c520611mr3643378lfb.38.1692286873648;
        Thu, 17 Aug 2023 08:41:13 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j7-20020a19f507000000b004ff89fc80aasm1118656lfb.233.2023.08.17.08.41.13
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:41:13 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso12294104e87.2
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:41:13 -0700 (PDT)
X-Received: by 2002:a19:9142:0:b0:4fe:819:b0ed with SMTP id
 y2-20020a199142000000b004fe0819b0edmr4172868lfj.46.1692286872972; Thu, 17 Aug
 2023 08:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230817050332.1274751-1-yangyingliang@huawei.com> <20230817050332.1274751-21-yangyingliang@huawei.com>
In-Reply-To: <20230817050332.1274751-21-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 17:40:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvGFdCcdHqfFV_N+r+bS9xTeVS+kc0tTW5=QxgpVLKog@mail.gmail.com>
Message-ID: <CAMuHMdVvGFdCcdHqfFV_N+r+bS9xTeVS+kc0tTW5=QxgpVLKog@mail.gmail.com>
Subject: Re: [PATCH -next v2 20/23] spi: sh-sci: switch to use modern name
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
> Change legacy name master to modern name host or controller.
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
