Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EB16EFBD1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Apr 2023 22:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjDZUmg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Apr 2023 16:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjDZUmg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Apr 2023 16:42:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC2135
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 13:42:35 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so88189276.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Apr 2023 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682541754; x=1685133754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIDP59Myi8dfg7gwveqHDngbZncEz1dYSlvsaTTJByQ=;
        b=f8/Iay1jcqp76Q57GKrLft79wxE9zxJbQyI/4Dg5j34/FwxCZTqLF2XG7I1CnxtRZz
         IAh4hXJaCUbuT5j1Ea24x/87FsJBP+7470pTvlKWL9rojMlGV3wYvq8phWrS+jEBFZR0
         Z9YPm8D8Lcr5IwGVT5K9M9Ktwkr7NHhTIuYrC4lyEUYkCjBIpEtx3e3YKBwgCOsfOuxc
         7d1HRxw1Nsua/klko0wUXmQ7egZoMMvMNUz5NKJEpBThxqIiED1cthF8mkQ9z3JkV+my
         Y+sWpO697wa+0OMDgOUIctMiMEzofKaMvLkv0RnHxm9JpLgzEjJxzMWkeY4I3Fgh4Mlt
         z72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541754; x=1685133754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIDP59Myi8dfg7gwveqHDngbZncEz1dYSlvsaTTJByQ=;
        b=cN4O6spD4Y0L1yGyqAad+avc+7GDpYMquolxV/y0b48O7/KwDv3T2Q1g6hRifAUEPn
         aTGfdsl743QRaVO3ZBO0rvLtMJjbaTPP5Z82oBHmCGpDuE0qQ5iQvD5AT7ibMYuaLXX7
         n/ezwa2rp9UaspVVBxqKxf80IJvqDgyHN/8N6iffZGh9EI1oqQIJRItJouBtUPOqrbc3
         3VE3VocRRSan9pyUs7ql2lJWxWUDMmO623dan8lQKuOLT0jQoyXwEEfBdjDGBbR+TUBR
         X786X9SrdH3VOIRsEvWJIQ7NOh7OXPPRKMnT7jz7AHWhEMV9V13UUsBCz/mfyv39jWjn
         TEKw==
X-Gm-Message-State: AC+VfDwbK8OHEKl4dsjuWaIMPtJC9Zn7VAnG/qLsNc+XvX9gQCzz+Njp
        R+xuh0KD0pB5MQmWX87iqZ8dE5dv1HKegziEtkZhxnIsOHyHmfLtuD8=
X-Google-Smtp-Source: ACHHUZ6TsZLr5BMq4JWZHcssgX8+DaHhdcowYIU/tMHL3MlKBuwFelehc6V3GkJb7v/fdsN5P1sKIiMBLm74LLhiUH4=
X-Received: by 2002:a81:f4b:0:b0:552:a4af:da with SMTP id 72-20020a810f4b000000b00552a4af00damr2630744ywp.10.1682541754720;
 Wed, 26 Apr 2023 13:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230424123522.18302-18-nikita.shubin@maquefel.me>
In-Reply-To: <20230424123522.18302-18-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Apr 2023 22:42:23 +0200
Message-ID: <CACRpkdahL+XZigkjCe71WZrs+biFj+T+LknPqMeeafmEbfE1hg@mail.gmail.com>
Subject: Re: [PATCH 17/43] spi: ep93xx: add DT support for Cirrus EP93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Apr 24, 2023 at 11:35=E2=80=AFAM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

> - find register range from the device tree
> - provide clock access via of
> - use_dma as a DT node
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
