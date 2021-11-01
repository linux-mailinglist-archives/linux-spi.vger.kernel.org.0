Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02E441E21
	for <lists+linux-spi@lfdr.de>; Mon,  1 Nov 2021 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhKAQam (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Nov 2021 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhKAQal (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Nov 2021 12:30:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F196C061714
        for <linux-spi@vger.kernel.org>; Mon,  1 Nov 2021 09:28:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j21so43353955edt.11
        for <linux-spi@vger.kernel.org>; Mon, 01 Nov 2021 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rt-labs-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrHGYjuUOc+17g7gYztL6hIZvCKPS87+X/NwwWqDiFw=;
        b=aYWpML20MdzALjWVl97FNwJCRThxNfaV1GKmCA28iLoh8Xd4XyJPzCkh9YRzJOLFlh
         awzpSa303WfbOMLavsAgNfpeXHn3zN7PeMQxXk0Kug2ei980wD2T5VLkCaaAjZn00/Ov
         iRe1qJVi5fZJ1gbM+gE1VH85E1aetirBzp48Jv+le1r3RXPaXDPz3tqCzu5HsHkelMip
         OKn0W5Tr+aWHtntKE0A9hYyMqeZh8iEqugk2XND+M5aQxTegRTbY1ElOu3V+DQgfql/A
         j1/8Abe2UHgumfDYewvksEln+O1hPHuDnkfXYc/nqXYn8H6ZxHRLqXWoPQ6SAsOoz7+2
         yv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrHGYjuUOc+17g7gYztL6hIZvCKPS87+X/NwwWqDiFw=;
        b=kfyU6/GP9mSKmdOr8SGg4gpE3Nu4NuAKptZ9VxPT3P8HFMTDryXvo+00AiK76scGTY
         eTUqh9wvDibTEAnP1YFgEnhzjJ7JnoVr3Rr+ytlJNzHr87RFls26O8VOvagCO8T6kFOE
         2mvhqDyvD58DiKzH8sq6eW1480kkVMKnJJnkpVxhEIWJVPEg5nUTm3f5bvVL/1XdSChc
         CeHlhnkU7XnPxyGqp4E0FhxLeIRQkfzS1N2Ozxwx6KSWkOxTSy6L37lcALW8KGKZecVY
         Ml/TOkG5rnJ5Jt5qXwUyQYOs17Tw28m8qUKY2g2Xwb865guoc2pp7IU1Ch92lfi89tYS
         f8Rg==
X-Gm-Message-State: AOAM530aQs17dMjV2mpRPEL2syKvVqJl8NGvY58R7hb9X3tpcHC2biHj
        ew2VJJJay+3Q643DPb5028mbeFw0MtXpN9o9SgOo0R4QUIc=
X-Google-Smtp-Source: ABdhPJx72XATCY/7pboCFvOPpSck97R6tHndyJb1S3wUIcWzxtduLca1jVcyn7IMlUeysDR2Mn2QvTl7LRVfQpvpEs8=
X-Received: by 2002:a50:da0a:: with SMTP id z10mr42143914edj.95.1635784086521;
 Mon, 01 Nov 2021 09:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211028130500.6727-1-joakim.plate@rt-labs.com> <CA+ZeBh-FBBQc6+2w70+9D8S23ApffXitoauQkwc+8RVqu6Q9ww@mail.gmail.com>
In-Reply-To: <CA+ZeBh-FBBQc6+2w70+9D8S23ApffXitoauQkwc+8RVqu6Q9ww@mail.gmail.com>
From:   Joakim Plate <joakim.plate@rt-labs.com>
Date:   Mon, 1 Nov 2021 17:27:56 +0100
Message-ID: <CA+ZeBh_NaixafiZ89JPGsu-G-=aLtJfj68fgWcyS0HCq218zoQ@mail.gmail.com>
Subject: Re: [PATCH] spi: imx: Respect delay_us
To:     linux-spi@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I think this patch might be superfluous or at least need more changes
to work as expected. Seems the delay_usec feature is actually
implemented by spi.c. So it works, but not by hardware support. I'll
retract this patch for now.
