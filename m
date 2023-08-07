Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091CB772D27
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjHGRin (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGRim (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 13:38:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CFDF9
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 10:38:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so7546554e87.2
        for <linux-spi@vger.kernel.org>; Mon, 07 Aug 2023 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691429919; x=1692034719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeLMkdS4bEOt6i78w7d+SDLHGpVLJwpOL241iqSqZlk=;
        b=4zVRQB3AZ586JXNQoQhXr8R2SDlemOEvMtMspbdZsW+vLeuxbMmIMHV+DyTKCER8HN
         MxBAwgGntntyBWutPNqv8YSYlxuOoXPlalCRN9b2WMSYfNb8vplS6M8bXKCTOVwV1wV+
         QJMe7Fs7cws4u8ytlrrKTP5pYVp5jdTXnshcW8+x/1jebRoXi0GB+B3iS8KD7XEYI0HJ
         RAySIoeW22nKEmzBzJVfSgq3HO08NrC8B4xRsItK4QRZAN2RqlWsV7t0+2Nx55q0PzsI
         z/Jzi1fH2enYJo0KcORl9KvqKUfT3axetwkcelwvEn3Q3DX3kTInTg7W11+HBdw5hZ2J
         KOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429919; x=1692034719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeLMkdS4bEOt6i78w7d+SDLHGpVLJwpOL241iqSqZlk=;
        b=BkM+tM+DNXmeMc2UD3Kmc0ct3msOiFpFMHik93Piy0qk33pEKOet0A7gJA2bR2uZXu
         V83nQNW1Hl6u6HFPEyfzkmkQaKIx+SIVuXz2T41rLBIwYNe8Pckj57XVKWRTShkyaRIR
         vkt8n8afhJKs2P/W5GPetM1YamnluNJu98ecNmapMJ/3jCToeGKKNKKesXjMKELpiJYK
         u2O2h4FyuaYyMbia+o5XC8KiBFPuRNHjBB/Jv1AK/D+ZoW1uFlWw0iYDjkQTg7lz6Yhq
         xIM8Ebh7GeW6bCBZ8QSLm2zTFdXVHO1NeE+S3/BuSMkAsuJYN3lM9iRidc77TJAwO6ub
         zYZw==
X-Gm-Message-State: AOJu0Yx0NI1RBQx/LI1VMRI8ufZ7TKaHGukgn8xmQz7lroZYQDlvb1jc
        R7yStT0wxhy8vic8FygL3iLVsxLWzotgjlvBTD0Rag==
X-Google-Smtp-Source: AGHT+IEzmiMTr6ANKOt18g/8iLIrlI4zDOz7TuXjpBy7vxgTnMv2IQCSTILzAT8WyXErRgZkMhpWb0+iPj038CLoSGM=
X-Received: by 2002:a05:6512:398a:b0:4fe:db6:cb41 with SMTP id
 j10-20020a056512398a00b004fe0db6cb41mr8477776lfu.39.1691429919236; Mon, 07
 Aug 2023 10:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230807130217.17853-1-aboutphysycs@gmail.com> <c867e685-7665-420b-9478-bce6eb067463@sirena.org.uk>
In-Reply-To: <c867e685-7665-420b-9478-bce6eb067463@sirena.org.uk>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Mon, 7 Aug 2023 20:38:27 +0300
Message-ID: <CAH3L5Qrzk-7WoF8+GKMYS40Dj_fxGpiLrTvVB_PJdA_VZVsDAQ@mail.gmail.com>
Subject: Re: [PATCH] spi: gxp: removed unneeded call to platform_set_drvdata()
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nick.hawkins@hpe.com, verdun@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Aug 7, 2023 at 4:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Aug 07, 2023 at 04:02:17PM +0300, Andrei Coardos wrote:
>
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
>
> That isn't enough of a check here - people can still reference the
> driver data without going through the accessor function.

So, is that like calling `platform_get_drvdata()` in a parent/chid
device, to check if the driver-data is set?
Would it make sense for another driver to do that (i.e. check the
driver-data is non-null, but not access the data)?
I can imagine that being possible, but it's a bit quirky.

Or, is the issue with the wording of the comment?
