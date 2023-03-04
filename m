Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C06AACC3
	for <lists+linux-spi@lfdr.de>; Sat,  4 Mar 2023 22:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCDVnp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 4 Mar 2023 16:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDVno (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 4 Mar 2023 16:43:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE3E068
        for <linux-spi@vger.kernel.org>; Sat,  4 Mar 2023 13:43:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so23954775edb.3
        for <linux-spi@vger.kernel.org>; Sat, 04 Mar 2023 13:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVdfTRzagZpxrbPS5j0VXfk6cXHcDvqw5oLXINe0eUM=;
        b=KH9O3NKPoK8JOIJrxiYSbYUUv+6/3s/y3vevE/holb4QYp4HO/Ed+aW/pQ1wb2JDIs
         48FxkGdEG/ZM/AjHLViSMTrlHXiYYvlRE+AQaRAOnoJK6Y/qn8cap4E4uJSSl/99Jr8O
         AXqFtve5u+fisJGCoEZJ+yfIJamppq3oTW+amJo57NxfKY0oyWCzgNuocWdCa8oijuqw
         sAHkAA1D0gvzWc2mXQSvwGJ28Fkap2pPzj3x3IVwmeYI0ebdxkgqO+eZ1OQ0+TGmj3QB
         /Ek+VlXQ9LuhgozkYpvnJIax1Ix0ciZhV4JiB0Cn4l/u0GUeKxXHno+qGr4au1B+MNMM
         5qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVdfTRzagZpxrbPS5j0VXfk6cXHcDvqw5oLXINe0eUM=;
        b=OCVL1t+PAn6o+JAkMCim2Vw8MCTPQ9TDBPpNXE+73vlC4y52LbTnL03SPTL+bFqJHN
         wqdpqoEKOw2jNKii/Lpgj7i7UV58dntMnVpKCzaQJbZdsdEFOYxYzruqKgRGyTy4eOvn
         YCDUuwEOAObrgOsaswiS9t5oAOseEm+JNomU1MRNXI/EtFib7kCTWsPzjvg69qjghpud
         pO/EgslkAPqCMyuzUZPx6Gne7iZ3/T/MOKmImW3sPuYbod1powenluN+r1LuS59jyiLC
         xp2uBOS63835d9BS1xKjFSA9dmwo1j1MeV5YxWSOloOVjDxI95SeFtkHd/AtShjYeV6r
         XfoA==
X-Gm-Message-State: AO0yUKUQjj6zi5Tbeec/+pe/g4aI+JXiPWPlUpsMjBMAHCcixxvV7JQZ
        8h+PNbfdhuxqE6YcQtxMQ9XWGWpdk1z9o+UhuoQ=
X-Google-Smtp-Source: AK7set+10mRjo9ATOn559XRqhqAnLr+AsGfHkSGLroL9AShCLDdP3latr/YZ1F0TqTBbjYDE1LUD8iFfpiKLdmz0QtA=
X-Received: by 2002:a17:906:5857:b0:8dd:76b6:65b3 with SMTP id
 h23-20020a170906585700b008dd76b665b3mr2900086ejs.4.1677966221622; Sat, 04 Mar
 2023 13:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de> <20230303172041.2103336-36-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303172041.2103336-36-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 4 Mar 2023 22:43:30 +0100
Message-ID: <CAFBinCB8V6CNB5n1E4C2SrZEqw4bU4c+i8udEsmke9eBXSkSag@mail.gmail.com>
Subject: Re: [PATCH 35/87] spi: meson-spifc: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 3, 2023 at 6:21=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
