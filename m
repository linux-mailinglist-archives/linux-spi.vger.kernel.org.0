Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE32B2C6E7E
	for <lists+linux-spi@lfdr.de>; Sat, 28 Nov 2020 03:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgK1CbE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 21:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbgK0T51 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 14:57:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96257C061A54
        for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2020 11:34:14 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f18so7048475ljg.9
        for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2020 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RBMXiQOLE13g0hTPPwsor7p7yq+DmjbzJB4mrcFwrc=;
        b=bk5CK6Jab1cYgzYCxJL0J5F2fvtwM2+00EPaujsMTBwIyJ0n6Rje7YjXWaS1WEHn2J
         eF9TB29I9qNJpAzLmg5h9tTjdRDXbkpK39cnjO2g03xMFdx7EM5Dv3p8kmCjTV5TmbpW
         oKJdID83V5n+Md+1mkYj2hF75LTuiOtyzai2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RBMXiQOLE13g0hTPPwsor7p7yq+DmjbzJB4mrcFwrc=;
        b=oBCWEPrk4M3q5EwH/YgIcBG8SFG/ZcY/fsBKZBzEnxZu5bhDaq15ih8io60yMcRCYx
         SJQdHHuwwcATMQVXQqnm3zkB1MfQ1v/Nlh+H+jc5Tasc2VigV2E2rTvi/r+Wg6gfV2S3
         nQS9TEOVL76kFIgao9vsMt1tdKKXgjPxGU3m4lBS2WHllZ3XpAtumxGj8Umthwyq0Oas
         5tHcKlH0E1VObv1qc/zfyUKsWVwO/bKr1FhjP1r1e57GnrohlAQPV60+opnzOROkPo5Q
         MAQNOkA638a/kZbo2Jf7lmEHTqD3T8yoHcWzVIFEr2Ew08t9fwh2KLzcaT08uXlMW2e+
         VAWg==
X-Gm-Message-State: AOAM53049PqAI7DRuQDbOAL3FDTjULS68t5xMTXvjCXOrHLJITdB6esj
        Gw/PCAri+JAU8/hPKBi0jMGPTbluvk3Eew==
X-Google-Smtp-Source: ABdhPJzD8cJqfjAw1QxMgUgN3KNgihRxwTKZAm/peJCdlfSmLoy6APv/fIGvd5218zsSkzZTHhzIpg==
X-Received: by 2002:a2e:1607:: with SMTP id w7mr4136402ljd.419.1606505652784;
        Fri, 27 Nov 2020 11:34:12 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q20sm828867lfr.110.2020.11.27.11.34.11
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 11:34:11 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id q13so7788064lfr.10
        for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2020 11:34:11 -0800 (PST)
X-Received: by 2002:a19:3f55:: with SMTP id m82mr4124071lfa.344.1606505651430;
 Fri, 27 Nov 2020 11:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20201127134907.9C8BA221EB@mail.kernel.org>
In-Reply-To: <20201127134907.9C8BA221EB@mail.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 11:33:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJwRvUHvwYeqxKayE4RZqowSDyEdB=hpVmqHE-JCFk0g@mail.gmail.com>
Message-ID: <CAHk-=wjJwRvUHvwYeqxKayE4RZqowSDyEdB=hpVmqHE-JCFk0g@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc5
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 27, 2020 at 5:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> A few fixes for v5.10, one for the core which fixes some potential races
> for controllers with multiple chip selects when configuration of the
> chip select for one client device races with the addition and initial
> setup of an additional client.

That's a really hard long sentence to read. I was going to try to
rephrase it to be a bit more readable, but gave up.

Anyway, pulled, I just reacted to that explanation not being easy to parse.

             Linus
