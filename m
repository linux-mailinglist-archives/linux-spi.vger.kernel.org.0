Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A542B2D1
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 04:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhJMCro (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 22:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhJMCrn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 22:47:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B37C061570;
        Tue, 12 Oct 2021 19:45:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 187so1133462pfc.10;
        Tue, 12 Oct 2021 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UHFIYfsr7b0jorNK9esjy7Bco5dFhmaQZHtoBUluqkI=;
        b=EE62e7bvHEEs5P9ImtD6JTzfgDXyEABBvUK83EPpd3n2NEOJaefadUS42AyZEzRBjk
         wH7h7mM30DcDFYjdZSc1SQCqRGI+S+V+269Y+egNe0Snut6wJlBl8RwMrH3u04b5jERe
         k8MVVS5fP0e+1Dr5X9ikC3eER1NNFKKnrndY/U8C4zXzIh2MgeoMt5roA/xJZLnyzxYk
         mDQPASl0oGHS0AANHbQu0Y8wwESxPnjiOpm35K9G7Jy2dlCH3VOyL0TJDkSVqRMacnsZ
         RimSogMkTdQNpzkmqUdPkxEedMJQeC9Mri9vdgRGnJnmGrRFqgM4GsUzdxHFsIygx6pN
         bs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UHFIYfsr7b0jorNK9esjy7Bco5dFhmaQZHtoBUluqkI=;
        b=bVgRqxIopYMIC4JQI0l2Z+3M5L6QtuOATvrqY+lsepsAxg6L1AAh6RZ0v/38NSuVp5
         97Bc4MXuV30HfJoxZgJrbZ0yz2df0GNfZs1/ZZT6+h5XYmtaXPWfdymZ9qExMAL7amap
         wayRixlDtaaNULKU5tuStFfDbPqyo90vf9G+UNdZzW+NIi2zNZlqIjKMylHuH5nekaby
         uXBaffVfm0bKgyyHezUER8Llz+swRLizMADrvfmZt7LFQNcgjxNlFfuDYIJX//G6iK+Q
         9zmow3Q0eBMYArd/UdLh9GpRcvSbrs/OmjtXB1ZI0wV1GMoWJRJ1BUqYqfPjEoj6eZRi
         l6lA==
X-Gm-Message-State: AOAM532Slqe260G48/m64CCpphVEmGmXPWH8yObvqlQPzHxTo8dQ1EZz
        7EKQpQS4v3v2FmMbnZBk9Jk=
X-Google-Smtp-Source: ABdhPJwS4gt1/UI25av5/oaPIh1mcdjHhlHvJkBJ+eTSBrpodZfeBtOId29u+rn8v0FzymrbyO2Bmw==
X-Received: by 2002:a63:da14:: with SMTP id c20mr25848546pgh.155.1634093140226;
        Tue, 12 Oct 2021 19:45:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:618d:87ca:8f95:87c0])
        by smtp.gmail.com with ESMTPSA id y18sm12121225pff.184.2021.10.12.19.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 19:45:39 -0700 (PDT)
Date:   Tue, 12 Oct 2021 19:45:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 05/20] input: adxl34xx: Make adxl34x_remove() return
 void
Message-ID: <YWZIUE5B1l5r4QEs@google.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012153945.2651412-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 05:39:30PM +0200, Uwe Kleine-König wrote:
> Up to now adxl34x_remove() returns zero unconditionally. Make it return
> void instead which makes it easier to see in the callers that there is
> no error to handle.
> 
> Also the return value of i2c and spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied, thank you.

-- 
Dmitry
