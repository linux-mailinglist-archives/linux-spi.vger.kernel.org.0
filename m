Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307976AACC2
	for <lists+linux-spi@lfdr.de>; Sat,  4 Mar 2023 22:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCDVnd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 4 Mar 2023 16:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDVnc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 4 Mar 2023 16:43:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F4E068
        for <linux-spi@vger.kernel.org>; Sat,  4 Mar 2023 13:43:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o12so23811045edb.9
        for <linux-spi@vger.kernel.org>; Sat, 04 Mar 2023 13:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVdfTRzagZpxrbPS5j0VXfk6cXHcDvqw5oLXINe0eUM=;
        b=AdsIcWEfClxOK/eImiVP68J7ArzbxApR51jRAXUa6RPrDaVOdaaF+LcQ+Tbd+uni0J
         yws+bPF4VjlMvCpsH8q9ZoXr20HgrWwLuIZu6Id5DefOChd+L2d3pEDCss+GHTy/u1vy
         fcyfFbGcHWjvbhXXEWDt3JQiO84QavCMk4iLr0Y4f7oj01vNspYOlYtmjP+Xj70o9vYS
         CmpHo9sBnym6OKL2uqcG/gngSSjnMO8PhC/fMg0ow0GH4/HbEFwN4Oub4E1kx+/q4LoJ
         27fp2UcxizZOuWC/scsKiRMyCTwDCT/x7rhhUXb3oY0YvVlPvQRFhlAojL8WkixcTBdT
         DGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVdfTRzagZpxrbPS5j0VXfk6cXHcDvqw5oLXINe0eUM=;
        b=vEfiUeMqJCbvZOhfyQmtikkckgzyALPPoAY9RfhJgsjdhflsG93vF9aZRWkasStPJk
         QGVu6rwyIn2jwyXW4h5tlsoQhvpKWdIQLUBK26jTn6lFlYMjaJJonbq1tV5m/t+sYrI7
         ++x0Mgcm1gKHUVBtIEHgoq4UEzd9V3x/V0yrDy4V0DWneBGTfiMQXTz0JD2IU76sCQCJ
         jW1bEpIfacxJpVQiOZY7ZGHC4lx2PKWeq5udRXnZlMxLqyRBxlvJPW/zg2hZjrIMCviC
         KK6w69/gw48rBTsgB9UaY9iXqoeLqUBhr7A+3q6SUS8yAqulrgXBvo87qykw8WNxRRxk
         0xPg==
X-Gm-Message-State: AO0yUKXRgjXxlIb6hwr4atZ3zGjX7fLiIrDv5iUOzA6ha5mxocemL58v
        v3UQ+IPmTF1tKuDe3yhlkEzm/73caEMe7GHUaxM=
X-Google-Smtp-Source: AK7set/Q/N204TLUp9rYTAplOSGGKTHM46UUEpnPCOuXBduR9v7W3yM5Y8gVcuFhnO9M0+konGtN0Icw095lXkYFuio=
X-Received: by 2002:a50:ce19:0:b0:4bc:2776:5b61 with SMTP id
 y25-20020a50ce19000000b004bc27765b61mr3349823edi.6.1677966209891; Sat, 04 Mar
 2023 13:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de> <20230303172041.2103336-35-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303172041.2103336-35-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 4 Mar 2023 22:43:18 +0100
Message-ID: <CAFBinCA0OQc2n6A18-ey0E11PArDQNX5eWTCSwWgVnZJa_EbPQ@mail.gmail.com>
Subject: Re: [PATCH 34/87] spi: meson-spicc: Convert to platform remove
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
