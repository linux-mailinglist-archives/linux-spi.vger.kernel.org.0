Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF2720A1A
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jun 2023 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjFBUCk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Jun 2023 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjFBUCk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Jun 2023 16:02:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC59D
        for <linux-spi@vger.kernel.org>; Fri,  2 Jun 2023 13:02:38 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba8151a744fso2508446276.2
        for <linux-spi@vger.kernel.org>; Fri, 02 Jun 2023 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685736158; x=1688328158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKpM70iut4VL/i/tNwIJ6FRXcVMH8A9pJiWYgjw70Z4=;
        b=LBXEr0Gz9/jSE2IzPO1IS6zEcw7CKaf7ShCxPcbfHiIRcMVyHJE6jlqruEdXiPRhsN
         t7QPfE21VrMd0e5MA4poZyXSWlKz99pmyuZ6nbFlYITw+zQkkxJGt3TyoBe3wj5pp0G+
         7cgf49PL2G5mDCbvxlJU07M9gTI6xB+pea5jYuRjypx2zECLDS0EG1/tCMgyrB7uZL9L
         UdCaMZyGf4wccXYxJT6yNVSM2SPeNbRVfjFCNVB9r/EOaeU9nlYCW0FOc653YJu3+x3X
         i9g99X8wWPuNiGo4+NndFkSh9qXz23oUBbP+QALXauKfyDT5PPViUFxTGt+AV6EIDvxK
         05sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685736158; x=1688328158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKpM70iut4VL/i/tNwIJ6FRXcVMH8A9pJiWYgjw70Z4=;
        b=VwBI6maIxM1P2rDTI1KTo+oHUfYL/Rag+DYbcynE1YCVGC9f7xJLpl3SXiKMYvzM8v
         lJ6ogBjX83oxUnf1t/p3oa1HuyiEfyQ1HbL8hLT96fnB2lGr8/w0lq9MnA44Iqv7620J
         gLEDnyPmQxl4OmzrORcowLezd7MP0RCxzTUULX064ohodpHx+UaDH3s2GbaGUruvEful
         JyPnM2ra1Uf1ycVyrLjk62IxhGl5toPepWfKb7SQ4PklqQeHWUVAIzCwEY0Ut2kfLZbA
         GQpf0zyxSMcUSKBi56OtQKEt7PP00ale3yYJgBLwqqmnB8NnwaCXTqZZ2YmgpsXYNnLS
         N0YQ==
X-Gm-Message-State: AC+VfDxJNVV1j/YGFBfZ/HCEr3v50dkPTOmMx+BObjcmkjVOf4LTQsmw
        DtFY3aRSaL4Y8B10u/qt06VJ16JgaPWwrjgp6sYMQA==
X-Google-Smtp-Source: ACHHUZ4jOpJdukkSCa5e3qroZIItg8oz58sxAOAyc2Z3apFXdNJNcmOUzPtJWFFQmuHO/M0hskfAOw+6OPoF+v3C4Kk=
X-Received: by 2002:a0d:e0c1:0:b0:566:584e:5ce with SMTP id
 j184-20020a0de0c1000000b00566584e05cemr1045478ywe.34.1685736157943; Fri, 02
 Jun 2023 13:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230602-pl022-defer-fix-v2-1-383f6bc2293a@axis.com>
In-Reply-To: <20230602-pl022-defer-fix-v2-1-383f6bc2293a@axis.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Jun 2023 22:02:26 +0200
Message-ID: <CACRpkda53synLQCyRPVHA20CFMOUVo6c11-m_ckdvru5iOf0Og@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spl022: Probe defer is no error
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 2, 2023 at 8:13=E2=80=AFPM M=C3=A5rten Lindahl <marten.lindahl@=
axis.com> wrote:

> When the spi controller is registered and the cs_gpiods cannot be
> assigned, causing a defer of the probe, there is an error print saying:
> "probe - problem registering spi master"
>
> This should not be announced as an error. Print this message for all
> errors except for the probe defer.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Excellent, thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
