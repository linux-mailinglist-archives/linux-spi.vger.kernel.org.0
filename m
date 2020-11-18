Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976BF2B731A
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 01:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgKRAb1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 19:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKRAb0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 19:31:26 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FAC0613CF;
        Tue, 17 Nov 2020 16:31:25 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so279510pfg.8;
        Tue, 17 Nov 2020 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=47SWtasEytDoDRyJHDoekvy/wBGX282Q45nU6ZNPmD0=;
        b=V7bK46oL8GZ8BlAf5Gg/xm24qZGUbQD1IaDASznpm19Ct2rSKrR962N//p13IMLoCE
         RDps1RuoldxeK8e5BNG8+lWdZlEojocz2W4XpywXklBB6kQ/HPtdyFZkdHn/foMjKOgE
         dnW90Toc6jMeawxU+LCiYgwwY7Zu6I5j1CUkgucZqxE4gZssbwpH1nb1pcjf29MsoXzE
         5saRvINvQcAUBRqPzfAPwxi9RHn9WocqOSxJXtSsaY2/a+3H1gZKVjCV4lmTeKjyPtFv
         tc79keeDE8aQMvFARVSbAkm2Jtg+wVywePoKloYMKFSdfY7e2FYzjvazdRnSaxjTYwQt
         wYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=47SWtasEytDoDRyJHDoekvy/wBGX282Q45nU6ZNPmD0=;
        b=hgUkfghDh9JDUCKAwhSVBlaT0kub3Z+ETZ9lipnRdhQbfoP7fVjthrzUo/kOyvvpxL
         NusgykuSRZA1MfBuHbrRwfu1BZ8Hf5Wt/Oa88rFn3W4e+sSMuavKQUxlPzlcOsv0Twsk
         VR4L2shCzfJUZGsjYEwLY/F/doL5wqlLomKiKsVzPjK449TNNI3WLuQUpnEbBToq6gLP
         NhdRT7F2AgduPW/foe7Np2xe3WlJkq8RLkIbhEFXuZ3uMMXlOU2V3JTQ3A8522apCCry
         Hn8/AtLsru5w1YdL2/J+xwFIHZAzX+xBjyja+JX5LpZgNTYSXFLsL4r47crJP0yhKCeM
         5nPQ==
X-Gm-Message-State: AOAM530W2Ov39tCowpGGsFYOMuuphcTEqqzvYykermhEz2/Y8OTn2rJS
        mUJ0a/Xkzaf1WUuqv534vOw=
X-Google-Smtp-Source: ABdhPJzrU60dQjf9UZ+oq8kLcuhK2h1KdnUVCu+dn/b/zh7hVRleuaFbGWzjFK3x9t03vSYrXZ7tKw==
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id z76-20020a627e4f0000b029018c9322739bmr1930195pfc.7.1605659484934;
        Tue, 17 Nov 2020 16:31:24 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id m204sm9004378pfd.118.2020.11.17.16.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 16:31:24 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:31:21 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 1/2] Input: ads7846: convert to full duplex
Message-ID: <20201118003121.GC2009714@dtor-ws>
References: <20201110085041.16303-1-o.rempel@pengutronix.de>
 <20201110085041.16303-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110085041.16303-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 10, 2020 at 09:50:40AM +0100, Oleksij Rempel wrote:
> Starting with following patch, the ads7845 was partially converted to
> full duplex mode:
> 3eac5c7e44f3 Input: ads7846 - extend the driver for ads7845 controller support
> 
> Since it is not touchscreen controller specific, it is better to make
> this conversion consequent for complete driver. This will reduce CPU
> load and make driver more readable.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thank you.

-- 
Dmitry
