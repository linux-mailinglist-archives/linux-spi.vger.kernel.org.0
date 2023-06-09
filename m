Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAD729166
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jun 2023 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbjFIHls (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Jun 2023 03:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbjFIHl1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Jun 2023 03:41:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9161A2
        for <linux-spi@vger.kernel.org>; Fri,  9 Jun 2023 00:41:26 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5664b14966bso13353187b3.1
        for <linux-spi@vger.kernel.org>; Fri, 09 Jun 2023 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686296485; x=1688888485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agSzQAlA3vB7TiE+c7567YHsHwKsKQDGu0KW+ilGleg=;
        b=Xg+vzYG/nkVPeYJJh1Ji+jemWww54yCeuSV8daiHhILzKn0a26GLpcqXlZ0OUYlx07
         Ib6E6a/S+AU2+G0kFEvLaylkH8ddEDIZHdbty1OIw9dkLu18DobpppSvWmvVjGN4yF2o
         BDSBWRNkbhN/PcVAWo0BHKv0DoDyUPJ6LN5YtRDpdlQK+iXGh9ovlpEqe2Um47Y78TGI
         NHLnCP1oPfP2oAg3Q28jjQVNMQViOcm4jJ9aHShMsfYz9/Cjb8jgTuQdcdshRN4quaaM
         v36ZdfN+YIwISL9osY2y0L8t48LhO5R3P19p9wO2+hSk86ZPBf5YKzukK3oKprQCuoqB
         DvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296485; x=1688888485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agSzQAlA3vB7TiE+c7567YHsHwKsKQDGu0KW+ilGleg=;
        b=YiK57yu+4exrbQcAPLzANd87nIZK/a2AfZeETuK4jwXsrpu6EVkx1WA02Yv0Stgn85
         Hiwj4DcIoz0aXZkBQylfYP+1DiOdrEMDZo9aZhG3RgfpUcm/8goilrHul+2G01sjzQUU
         sTd2t1mUuA1eT0HzsiAfnwranu5SGKnLlPpw1k4dylVB9X1GByok0eub/rIb6FAmGeRv
         PcrYIMxvV6TlQYfb/VCM16RTW8or4xEag2GHrpAsrfDWM9RpG+6udMRKts9mCHOZ6xex
         i0tmFzwMFeEshgJH67ZHK4jgqR32+ESd+jZi7z3y8Y/HD7Tf0aLCg6DwaZ3ATkePrQxH
         VqwA==
X-Gm-Message-State: AC+VfDyUflqkuES9mOyCJQ4o1yoAyYYInzmSulkpvKTla12DBWLDHy02
        ktfpExGvu0MRJlKzFGUPHK7wSOldoL288jHjV41G3dMmfhEvJ/b5
X-Google-Smtp-Source: ACHHUZ5jlXZ5aYo7orLGKS89d2hbatJ50uG2EaQL3Q/iP+Sg9hANlFQ5bMNtha+O/K485bvlneepJoRkjzr5dl6RBec=
X-Received: by 2002:a25:a221:0:b0:ba7:dd71:36c7 with SMTP id
 b30-20020a25a221000000b00ba7dd7136c7mr295651ybi.63.1686296485284; Fri, 09 Jun
 2023 00:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk> <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
 <a1a1bf95-6333-40a8-9f08-4c952cd070df@sirena.org.uk> <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
In-Reply-To: <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:41:14 +0200
Message-ID: <CACRpkdb=2fogk3bEa4fkPVYQivnvLh1F1TnBj7og43ak+F8gPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
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

On Wed, Jun 7, 2023 at 2:55=E2=80=AFPM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> It is not clear to me what alternative options we currently have if we
> want a setting to be effective from the very beginning, before
> userspace is running. Of course adding a cmdline option would work, but
> that seems worse than having it in the DT in every possible way.

A agree with Mark that a command line option isn't that bad. It's something
that pertains to just the Linux kernel after all? And you can put that comm=
and
line option in the default device tree, in chosen, if you want. No-one
is going to
complain about that.

Yours,
Linus Walleij
