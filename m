Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D251D20D6
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgEMVWJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgEMVWI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 17:22:08 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8FAC061A0E
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2020 14:22:08 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so731422iob.3
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2020 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tGOgO3DH7KY7eGZj+l93dH69/CZG3Xhtwrztz8Xi5EY=;
        b=hOZtlEBO2LKyP8bHzFDDLBLE+AyP3GW51R2Bgu0+e70rfUZ9rIiczo3pB8s/u3VM70
         K0T9RD7NVB7brgPgne9G7Y9DKSqMwc34kmUSNaN1+tKmQKMyi7b2a/DSMwe/zY5/KEhq
         fQSq0XIBJbkr+PAekXcISSvdYkIgp1CyKT8+VJYoZrJ8KYzz0lTZCE6/MFJ87T2KQroR
         EtSZS930x4uhhtysV1nP2Ob/eQgc7gMe8HsNnHtxeeVeS/yekgc2kD61tz8HifWs7qcn
         aDv4sBzqEuxANANls7LL4SbixAH4tEKQkZN+1IFCsDhaPLM0Ftld10Il4H8V74Y2oTRm
         cjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tGOgO3DH7KY7eGZj+l93dH69/CZG3Xhtwrztz8Xi5EY=;
        b=I0GkSsEbKBuKIVPYRHMkgBiFnDa4gTZ4r/RFaqK/NbYxstk0O1m1s62Ess/PjHe0Ca
         OABaC3kQu5oLMuH5duXK75SudsolZ/lILr0U2a2kU+GL5uTHmtkMOP8vA2EJHUNjovhs
         aRvJVzv02gnQKORQFgbx2dhPu8pJurEd/SpnH1GkV8mvEKOMaZUkrQsaNwUNZ2kVHpic
         yg1Ue5ElBFJcDIynIoW6j27/a9cYBwSgNAJZ+FQgucY52SHos+UbIockmzs9uEV77sT0
         NaR2wczi7uVdHUxjk153kJnwgKed60IFvSP/SiBM1k7k4qctvoq76U+kGaQSTA9c1eHr
         NwEg==
X-Gm-Message-State: AGi0PuZ+18HijRkeAvRRPwSU/EgUylmH/BE1UF2xYNFnnmEXZyW/WvEr
        bxm4NkNNO6Z4SPepYiYzwyDkCA==
X-Google-Smtp-Source: ABdhPJxZH8ktcsDq2DKyrfz9mzAZuFt485i9jtYbwe1JvROnYtyNj3dkM5M5qWN962L5ecYak/nF8Q==
X-Received: by 2002:a05:6638:277:: with SMTP id x23mr1463557jaq.122.1589404927597;
        Wed, 13 May 2020 14:22:07 -0700 (PDT)
Received: from localhost ([2601:8c4:0:32f::7b7])
        by smtp.gmail.com with ESMTPSA id j90sm272733ilg.70.2020.05.13.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:22:06 -0700 (PDT)
Date:   Wed, 13 May 2020 14:22:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/5] spi: dt-bindings: sifive: Add missing 2nd register
 region
In-Reply-To: <20200512204543.22090-1-robh@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.2005131421010.18879@viisi.sifive.com>
References: <20200512204543.22090-1-robh@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 May 2020, Rob Herring wrote:

> The 'reg' description and example have a 2nd register region for memory
> mapped flash, but the schema says there is only 1 region. Fix this.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack, dependency for patch 5.

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> 


- Paul
