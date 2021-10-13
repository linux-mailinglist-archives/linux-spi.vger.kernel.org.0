Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB042B2D2
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 04:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhJMCrz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhJMCry (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 22:47:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9354EC061746;
        Tue, 12 Oct 2021 19:45:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so796026plk.10;
        Tue, 12 Oct 2021 19:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AMJ091IIH/U9l32H2h6TktgjxvmprJYOcgwJrCzaJKk=;
        b=BtIpIOQf0dV3oo5acKyDFsD/XTw8D3fGXFa142eSvQ6TYNx3zvJ/r78jbmvVxtgZMP
         9lQ9dksDr0PwSdkHdolEwoMagkKsvnG4BH0p/0g61hmZgZM4xAffNkgXciCq2TAVPmM+
         1CEkYeXpXu3O0T1BNAaZnwfDq/3aZrzGGohHR7aI+eOffrEPEROfv78r8Uct+n8kIydW
         FHPxowxr5pjsTFlKEFQSF4oFcdFFGyoKNgVBldx81ZlGVYSZNxCpON52d4h9pTIqbMcl
         WGoBEfFQ08/2gwmsom6rT/9mybxw+QuxpmnQlf+o1w6Ye20LS2Q1gv0h0B7i3XVqdcg/
         I2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AMJ091IIH/U9l32H2h6TktgjxvmprJYOcgwJrCzaJKk=;
        b=Jv7W7uQBKWb28Cf36ccVwim2CmVx1zdklS9JF0Lka3dfh2TeHYXQv8ODGyVkMw47vd
         HHekFbnM4SdDB1JDPR0L1j7TaDHxG8oPhWzzNSBF5VYwAS+F2xTu3F5tiz3oPSAy/yVF
         Am78ljnhDomOk8U3cBy6jhDgfONwKEOBB19OE5UpHXbuqe2g3M8To5f/hOt5vwS1LNwc
         WMAydpBhz8s+K4QNEm8rC2N+BZL/9l6l12wXZC6kWrxR6UxoJOg1qkZeEI4y6YDuEm06
         e6rj0pYGrjuicKqPjrxK7cOrDuPJh5ZYppmRTxB4tpS+/UQnYsWuhvbzlVXlqLeqRTNU
         2Oug==
X-Gm-Message-State: AOAM5335zuVWVjip1knKohlY+NfY8kUTjj16hTYLw4oja41naiJWQ4WP
        viUfYWYba/MmPi7pIcg2X6U=
X-Google-Smtp-Source: ABdhPJyHxqGIbz9LN2hJj/fHfwoo4uEBzFvlWyYweHLd2Un1zgh9jj0AJjp7IwYChC6enm8Vzd4Q5Q==
X-Received: by 2002:a17:902:8a8c:b0:13e:45bc:e9a9 with SMTP id p12-20020a1709028a8c00b0013e45bce9a9mr34026196plo.11.1634093151964;
        Tue, 12 Oct 2021 19:45:51 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:618d:87ca:8f95:87c0])
        by smtp.gmail.com with ESMTPSA id s14sm12256918pfg.50.2021.10.12.19.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 19:45:51 -0700 (PDT)
Date:   Tue, 12 Oct 2021 19:45:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 06/20] input: touchscreen: tsc200x: Make
 tsc200x_remove() return void
Message-ID: <YWZIXJ2mWQHtSrs7@google.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012153945.2651412-7-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 05:39:31PM +0200, Uwe Kleine-König wrote:
> Up to now tsc200x_remove() returns zero unconditionally. Make it return
> void instead which makes it easier to see in the callers that there is
> no error to handle.
> 
> Also the return value of i2c and spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied, thank you.

-- 
Dmitry
