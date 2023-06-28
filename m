Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05094741229
	for <lists+linux-spi@lfdr.de>; Wed, 28 Jun 2023 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjF1NUy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Jun 2023 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjF1NUx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Jun 2023 09:20:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E7FC
        for <linux-spi@vger.kernel.org>; Wed, 28 Jun 2023 06:20:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bd6d9d7da35so5809131276.0
        for <linux-spi@vger.kernel.org>; Wed, 28 Jun 2023 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolution.nl; s=google; t=1687958450; x=1690550450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGA6jxqN8vTcDS3wt2muKgODh4eayNigHAkX1s+Utm4=;
        b=DM28bS3zVl7LqD1wB6+f6W2ce5jfWKpWcC+hGhPHAWdzeVR7DtutGaZ9gVnwn/EiB6
         Pz9mDD8KpmHY3yQbzFDienNENZxX4JMLFK9nRIixXu5trv/etNgTNNM4fTsBx+IOBTgK
         sLShII9vBlLLI77k5XUCncIuUvNnQiQwFQy2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958450; x=1690550450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGA6jxqN8vTcDS3wt2muKgODh4eayNigHAkX1s+Utm4=;
        b=gSx+zVxSc5xLtbcvZe+/GhtmhDOHi58lxjG3P/b2/6IYll7ntHSZ7hpUH13SxiVDBc
         Qr4EjWGk60lmKW+rtTDHoHOF+0Nlndd9ueDm76A2ojPhSUm44XOBa8IKXKvaJ8VJLASj
         ASH/SgWQiSmWP9ZbMvAf3aimFWFU1YVR87ho6piH3QVz0wNQWDFkq82QeyUyLlx2Ujz+
         y8oivmbrsCAIWOO4fQIutmjttKAnr9ykR/kdlVB9xryBmxpg1idw8oXflDNphd+wgpth
         vjX9+oF/iYxtfTfMsuktjfdrwlgChjnSFH1HWVrETo3GnqLgpI8tfTDTtylLXrujHCgb
         6NGw==
X-Gm-Message-State: AC+VfDzBmUWexNqViCP32lFYH57hAGLcOOgbFX4X0W/B3N8VVipM0+s5
        c6k1/HfxydHpXEmsZj7EnFUJXucKkT3JXb551vH1ERQQLa1ID8YxdwMyUeDXOraZS+X+/NYBdTL
        VBpgcpIQkIYvdLNg4PbhM9dZgkabpGQ==
X-Google-Smtp-Source: ACHHUZ5vzh7jOCYjBp4RJ8IsPQl5raQ9wLO+ZE90Xiiggta+9PXzCzTN5UiOvpvxAJewg7KjMc+a5s0IC797yUYUJpo=
X-Received: by 2002:a25:ef07:0:b0:c19:3d97:b924 with SMTP id
 g7-20020a25ef07000000b00c193d97b924mr10615611ybd.32.1687958450389; Wed, 28
 Jun 2023 06:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230628125406.237949-1-stefan.moring@technolution.nl> <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
From:   Stefan Moring <stefan.moring@technolution.nl>
Date:   Wed, 28 Jun 2023 15:20:39 +0200
Message-ID: <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer length
To:     Fabio Estevam <festevam@gmail.com>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-techno-validated: techno-validated
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio,

In our application we send ~80kB at 10MHz. The total transfer time
went from ~80ms to 67ms, so that would be a reduction of 15%.
I tested it on an IMX8MM platform.

Kind regards,

Stefan Moring

Op wo 28 jun 2023 om 15:16 schreef Fabio Estevam <festevam@gmail.com>:
>
> Hi Stefan,
>
> On Wed, Jun 28, 2023 at 9:54=E2=80=AFAM Stefan Moring
> <stefan.moring@technolution.nl> wrote:
> >
> > IMX51 supports 4096 bit burst lengths. Using the spi transfer length
> > instead of bits_per_word increases performance significantly.
>
> Could you please share the performance increase after this change?
>
> Thanks
