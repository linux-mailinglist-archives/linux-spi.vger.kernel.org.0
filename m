Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF72B7321
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 01:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKRAbw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 19:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgKRAbw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 19:31:52 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC03C0617A6;
        Tue, 17 Nov 2020 16:31:52 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d17so33504plr.5;
        Tue, 17 Nov 2020 16:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5V5guK8eJ/RbQCaxbWVa238p+t1xonan72j5q2VmeI=;
        b=MBy/50CUa+jztmeopmG8F27CpTzEVBkeEl5dssXIHAeFD8q8yUh2jYucGHJZYnvRj8
         7diIxGD8b9+P7u+r8ia6cEamyYZZN5CmDrCvclbyU9b/MxSNz+mkM8qjed+bTQzrIOu+
         9tfeHyCPdh+Vgol7tk9dSf6BQJqaNVMFl4XnB6/UPRi5c7PeWMaVs15w3FcFgzwmBTsv
         wIk+VLKMn6Fm5W5Wbe5A1o+nnBacvj8kuVFoFfTRgRunXT3OVWu1jaAXMghNdqnM89lF
         wFZuUvA66eg0jP5eor3ZEZ9Oy+Ch4HfOvCEcEyXeAmT1XVIzHxIQuKoB+3r+t1MesrOm
         pwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5V5guK8eJ/RbQCaxbWVa238p+t1xonan72j5q2VmeI=;
        b=REOgol5Q2ooIT+u2uFwtiNnNkVAarOS5h8CIX/XKJw7nFkghaD55azKoNUriiJQ0bU
         HhzTl6L4hDdFAD72CPo3wXgAKXw/9SL97e3XWWOBo2fDVl75O+4uIEwAzi+G1q6wV3nb
         hLg84vs9ITs0e5l18PYGOJk8YzkjBgKW+k579xSvk210kQLyQTh5cC/S2tTuavNZxCbG
         M+9AMN021mCEO7VnYZhwRD6FvboC9OfNK0yteVFV1y6pGihyrrPsZmj1ArVTYrVjX/Xu
         6GtS/CxlqHeqPvkyDcgukZWX72gAIh53MxzF+EJan68/FoDxQt31947QQTH3YAt0tVgX
         Axow==
X-Gm-Message-State: AOAM531TO1XO3LRAqVPg3GxYzlJdOFUbpkF2bUWL2GkjjTYFW2yksP73
        jho6Zdu8Gu4sMrMIgdT6XeE=
X-Google-Smtp-Source: ABdhPJx+YQj/eEH6ERLBPN/Nf2YGJ3MJRIg0PFJtp84QY8Bf+8zvtebywcZN7G7kPB/oeUsjk/I1iA==
X-Received: by 2002:a17:902:8506:b029:d9:6dd:45ea with SMTP id bj6-20020a1709028506b02900d906dd45eamr2072035plb.72.1605659511654;
        Tue, 17 Nov 2020 16:31:51 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id e22sm252397pjh.45.2020.11.17.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 16:31:50 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:31:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v1] Input: touchscreen: ads7846.c: fix integer overflow
 on Rt calculation
Message-ID: <20201118003148.GE2009714@dtor-ws>
References: <20201113112240.1360-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113112240.1360-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 13, 2020 at 12:22:40PM +0100, Oleksij Rempel wrote:
> In some rare cases the 32 bit Rt value will overflow if z2 and x is max,
> z1 is minimal value and x_plate_ohms is relatively high (for example 800
> ohm). This would happen on some screen age with low pressure.
> 
> There are two possible fixes:
> - make Rt 64bit
> - reorder calculation to avoid overflow
> 
> The second variant seems to be preferable, since 64 bit calculation on
> 32 bit system is a bit more expensive.
> 
> Fixes: ffa458c1bd9b6f653008d450f337602f3d52a646 ("spi: ads7846 driver")
> Co-Developed-by: David Jander <david@protonic.nl>
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thank you.

-- 
Dmitry
