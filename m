Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8697477FAFA
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353240AbjHQPj6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 17 Aug 2023 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353239AbjHQPj1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 11:39:27 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2168230C5
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:39:26 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe0c566788so12458210e87.0
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286764; x=1692891564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7EichZtVY58OabLWJcHXMxhb7mSwDeBhM3Nr7lF2lU=;
        b=eHikbyOtyrAkn42nqRFETptgnL0sAPkW99QZhGQZIs2l8YDN+KGoF34MVyXgwT/W3D
         RedrMybJ+FNYjZjeSXCxP8SKJfj8dyxTP3ANzTBmYSW67PWSbod/00IJG9Np2gk0ayEe
         Fmya44cdB9B9E4f3kaKFD35MVNH124mBiJvzM9mlho2korQNW3T+Jeinyjr3ybpmaN6n
         DmFDKGVHAHnHhMT3cf1nutadKeK2BPIcbqZlESFIscvuKUcJRGXpcF3pBIKtMHfWMEXt
         OVhC5ltSjwJOidntmDvCp2SOmz+vSFWbr0LAANpKuf3IKE4duD9DLFT6Ym12nGsC4Izg
         rXaQ==
X-Gm-Message-State: AOJu0YxFGhRI7xe7X5owMM2yc4zB6G9sIac/m7BUfVu7CJ7RuxORPDhb
        g5eQ8ksq9pcGVjiIAOQeIv2Gg/xtGWMEJN4e
X-Google-Smtp-Source: AGHT+IHZe1DdGmRXflrdo4htKcUQHiKcp+nVqtXtYKj5zwf/a0SfKX3VvVBbDLd4AjaI5D9Nw63bzg==
X-Received: by 2002:a05:6512:2f4:b0:4f9:607a:6508 with SMTP id m20-20020a05651202f400b004f9607a6508mr4024412lfq.50.1692286763539;
        Thu, 17 Aug 2023 08:39:23 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2514b000000b004fe48d0b5a0sm3402503lfd.192.2023.08.17.08.39.23
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:39:23 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b962c226ceso121969931fa.3
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:39:23 -0700 (PDT)
X-Received: by 2002:a2e:97da:0:b0:2b5:80e0:f18e with SMTP id
 m26-20020a2e97da000000b002b580e0f18emr4697526ljj.3.1692286762908; Thu, 17 Aug
 2023 08:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230817050332.1274751-1-yangyingliang@huawei.com> <20230817050332.1274751-22-yangyingliang@huawei.com>
In-Reply-To: <20230817050332.1274751-22-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 17:39:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWewfFRn__LGUKyOQ5=T1bgcOTS-sf=yyVZKDY0GjA0Fw@mail.gmail.com>
Message-ID: <CAMuHMdWewfFRn__LGUKyOQ5=T1bgcOTS-sf=yyVZKDY0GjA0Fw@mail.gmail.com>
Subject: Re: [PATCH -next v2 21/23] spi: sh: switch to use modern name
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
