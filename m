Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040C75540C6
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jun 2022 05:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356346AbiFVDKT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 23:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352628AbiFVDKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 23:10:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B632E9C3
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 20:10:18 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h65so19103086oia.11
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FACxbqess0Pows5/Tzswl5y1waAC4sojiXabClOWhFQ=;
        b=DiB9bZ5be8Rk6ThORaXRfqlJvLIplqBA1rG4IAnxfUJP/TKDMXYIW9kXoijspHvjRQ
         ny5lrbejL89s3dg5MBonkXpAJfTfq6LysdWduwsS2jTqEOBGFVBrPTFUQhm4hM91yi1h
         fDD9a98h26aFzh9xxPwHCjPc5iyRUrcZpL2ITkkTLs4/EZhZ5P8vEsHRYz+jXO9nkyAD
         s+CZ2yL7n5OgyBZk2jlSw6EEPV99uo59Cf5VJ/dt6P8QLKApoYPLa0/2iNHNNwqMuqTu
         kAJR6iPw+BJuyarqgyyi3AGohpP2ZJV7et5DeoWtDKBwVyOdKtnEPg6JTEKxX3FeXUT2
         BYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FACxbqess0Pows5/Tzswl5y1waAC4sojiXabClOWhFQ=;
        b=ByPkgwc27WJBcFAKV2EtSyOWspTLOecXPW423zifhy+DhLvwQ8qctxS+McKVvY7PyS
         tO/cV7GYMSwgaWZk4Zmm+aNbOx/gSyiaXvp1dtEwiVvRaQIuwxsNlo8bQahJmx8VpUTW
         KsBKiVmEBi0Jc62ZDXD2+o+57KwvdYk+j8Csr/QurIXg7pmXFd+nRRFpeQ7xXrwGA/Nk
         N7l1mxD18liEmpZQwL+rIrnolOqot+zCWdohYcsIveZD0Ih6akpjia6Scqpw3Hp3904Q
         ZKZAklsNLXs6u8MZnzKUbWw0Pn68htc21BKtqUu/JGyzXVoXHMa/hJaPPBtUg4sJjWfO
         +EZA==
X-Gm-Message-State: AJIora+LuK/62aRQumB0SxK4Kp11rtPa5OLEzVxVq4utQsz7JCldfAUD
        wACl6fsgwXwtFfyK4uKvGB2JVsdMhyoRk2RdKg9Fog==
X-Google-Smtp-Source: AGRyM1vcp3QQY9elvVpTAygpjR2XrlZ2bVmjlkkgbXEQ0+1DHHwlXjP5EuCc5Ey6+JmWdHgoPXaeJgXkXORhzfdz/LA=
X-Received: by 2002:a05:6808:1485:b0:32e:c704:bcb with SMTP id
 e5-20020a056808148500b0032ec7040bcbmr704189oiw.195.1655867417948; Tue, 21 Jun
 2022 20:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220610074459.3261383-1-andy.chiu@sifive.com>
 <20220610074459.3261383-2-andy.chiu@sifive.com> <YqMzV/kXeHso3QW+@sirena.org.uk>
In-Reply-To: <YqMzV/kXeHso3QW+@sirena.org.uk>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Wed, 22 Jun 2022 11:06:48 +0800
Message-ID: <CABgGipVH08Wpxh1pEqUyebWTVKE=Fx5EBfpn-jRv2YLTUU19wA@mail.gmail.com>
Subject: Re: [PATCH next 1/1] spi: sifive: add PM callbacks to support suspend/resume
To:     Mark Brown <broonie@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Seems like the clock managemnet could usefully be done as runtime PM
> too?  In any case, that can be done as an incremental change.

Thanks for the suggestion. We will work on it soon in the future.
