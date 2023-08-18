Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B765D780E71
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377910AbjHRPAG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 18 Aug 2023 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377903AbjHRO7e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 10:59:34 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC653C3E
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 07:59:33 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-58d41109351so29444527b3.1
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 07:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370773; x=1692975573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCbx8sSiXJst2vO+SYp2uOGBF/tYnON+/dMtKH/tpr4=;
        b=HjoRenX5pVzAEoTH6SD5T7SG9mEonz41gZ6Ts3/te4tLn3pKqGXuqQ4pgy7wEvrQ58
         l4IRWdQsZ4Hs2CmJpi3teoRJpgHT4pvMSF8vDA6mYTRxekxtlS9c2y2AF2PSh1DW8fPJ
         D/0iwqkp8cRhp83DZMJk3msMqEpRWhhn56h8eDcSYxTGyKQ3dhOwaL5iH8j0D28BeUlD
         wUUW/4B3aufhQ0+9Wl7mkl8/tkI2ZqOxrgLifFPl1QaXpL4c9J6eZSgpMLbpFIsVnGqw
         BOOQMzOQxRJaFkh07YEe45EiUuoo0zsoQ7MYmXw1G7sRXp43DG0sbMxWtl7Kx8ZR2XJr
         Ll5Q==
X-Gm-Message-State: AOJu0Yzxn/3oiRctcEJBaQWcQYwU/nLYtyPwaCj8Zp0sbhrDpEwY0XGR
        puDk/Wini2x1EKmgcPnL9kFxVLSmsTO/+PsO
X-Google-Smtp-Source: AGHT+IGVRa8+bXNPMR1GH7IYWEv82uOo2Qs7G4af/ACqGv55ViHLIOQCyhs6rxh7T2QRhvHMU2E+wg==
X-Received: by 2002:a81:84cb:0:b0:577:3f8c:fc60 with SMTP id u194-20020a8184cb000000b005773f8cfc60mr7513577ywf.1.1692370772773;
        Fri, 18 Aug 2023 07:59:32 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d130-20020a814f88000000b0056cd3e598d8sm535367ywb.114.2023.08.18.07.59.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 07:59:32 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d67305c80deso1390747276.1
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 07:59:32 -0700 (PDT)
X-Received: by 2002:a25:db4e:0:b0:d74:3a99:ac07 with SMTP id
 g75-20020a25db4e000000b00d743a99ac07mr2584022ybf.21.1692370771969; Fri, 18
 Aug 2023 07:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230818093154.1183529-1-yangyingliang@huawei.com> <20230818093154.1183529-20-yangyingliang@huawei.com>
In-Reply-To: <20230818093154.1183529-20-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 16:59:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5EQkxOBZdvkaW20jz0d5mL78korJa9P0FyMyf3Yke-A@mail.gmail.com>
Message-ID: <CAMuHMdV5EQkxOBZdvkaW20jz0d5mL78korJa9P0FyMyf3Yke-A@mail.gmail.com>
Subject: Re: [PATCH -next v3 19/23] spi: sh-msiof: switch to use modern name
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

On Fri, Aug 18, 2023 at 11:35 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> Change legacy name master/slave to modern name host/target.
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
