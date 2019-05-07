Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3316641
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEGPJC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 11:09:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55478 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfEGPJC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 11:09:02 -0400
Received: by mail-it1-f194.google.com with SMTP id q132so11763517itc.5
        for <linux-spi@vger.kernel.org>; Tue, 07 May 2019 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMKxSMzwu+s2/SzB62Nh+x3vxif2iOJIy/DFOJy1IA0=;
        b=JttxCubqoLk3AhCSATJ1dG2YMRqkDdBeMD1EsHQl6xUaQs1B71zOLKZ5cMzviHJKwW
         TC/VBGHn1zLbnhTXdleyXucuXKeSTCELa5Q075xnaoCzKzXwWJR0FGxa4EWQs/NBOs/P
         8bgs9hxAdu1KMzEdD0Vh1GrRaWkc/Ekt5c7E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMKxSMzwu+s2/SzB62Nh+x3vxif2iOJIy/DFOJy1IA0=;
        b=qGJaDLR3n1xJ516Lhwgc5s/iLRiz5w4jbQFgrMk4vTiuv+298nft93zm+xlzPmN9HA
         sUjLgseiZi6n2KtRDnMhxFVsJs7nicnXrnb41S+isZrIxWUK8aI6KFQhVuGt1OpYdWTj
         K6P6N1lVUP728KsPFGW1Sd6R2gvXMdEEQbWhJWhPARWR68LXFSau6fN6fctj2SJufLiT
         y65zqeNve4S7cD86zR6PWnABU1yk8PPJWV8S2L6iQW45j5trQ7vdsdJUhD+z4pWHskGi
         NM2lI4OClClvFRF/eJWLD5x7VaQXxHvyIWYSAiMG2tRivbd8+G8f6oTXiD0pSd/j3ouX
         Z4gg==
X-Gm-Message-State: APjAAAXq/FP2ubOrSYtOE9LJPvvRAqpchyEoVN1/WddEA9ZMguZ4JkKT
        U94kSItp6EOdFwLVvqUzwpE1CPCTQuCle29RXph1gA==
X-Google-Smtp-Source: APXvYqxzxPAnUM9yMUPw0bSHqeGRGlrlpk4UlIXm0lTx42L8iYNvI597rZp60jpeX4QnxGdyIAI5VtNkTfFYR51QJ3A=
X-Received: by 2002:a24:9183:: with SMTP id i125mr21968894ite.105.1557241741389;
 Tue, 07 May 2019 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk>
In-Reply-To: <20190506143301.GU14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 08:08:50 -0700
Message-ID: <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 6, 2019 at 7:33 AM Mark Brown <broonie@kernel.org> wrote:
>
> spi: Updates for v5.2

Hmm. Please be more careful. Commit 1dfbf334f123 ("spi: ep93xx:
Convert to use CS GPIO descriptors") caused a new warning because it
removed a "for ()" loop, but left the now unused variable 'i' around.

I fixed it up in the merge, because I hate warnings that may hide real
problems. But I also expect maintainers to check their warnings,
exactly because the normal build is supposed to have none. So a new
warning does stand out.

                    Linus
