Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A665EEC2
	for <lists+linux-spi@lfdr.de>; Thu,  5 Jan 2023 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjAEObC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Jan 2023 09:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjAEObA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Jan 2023 09:31:00 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639854737
        for <linux-spi@vger.kernel.org>; Thu,  5 Jan 2023 06:30:59 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id f184so14231070vkh.2
        for <linux-spi@vger.kernel.org>; Thu, 05 Jan 2023 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DasKKmYCBdAgYdTQm1qej58trbtgsgodxEIvq55yTrM=;
        b=hf44kBeR7bIJ15DMBy4iKe7+a3AtLUQXeCeElgMUGveyLa9CKCoXaZZhskW0aMbw1E
         U7D45bxYmdtULpNX7hIIO1DJ2ziyw9sC7QXJej32OPwyKffEXWbfujoX4sk4yt4r7og8
         Pnz6kFrXkCCMK524sfdpZyZ4GgKFfxwrrrgYmZGqPValwmj4cYENqkATFl+OERaII7j7
         6CvmWkSBVc3JdE/Kk7p8a39QvNZpVvwOUmcINhCkHx6WZNt5KwP6yBUWg/lmaxwZUVbK
         BsGJidCFX0j4doHaibJad7oZ6JQNjqG1+MkC0JzgzLoydNSNg6oied/729AN35hU54k5
         6mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DasKKmYCBdAgYdTQm1qej58trbtgsgodxEIvq55yTrM=;
        b=kHpihJju4Pu1gHYDLlkK1lqzBOEPm1wolYY2sUeBRhRp1CpQPTdW4St2mp1s7NhTvf
         1mLffyczatainCYTzjnG//im6XIvzzPFikpfzmzdS/zM+KtzPAXgg5fpu2A2rId6Cur+
         nwqD6zpRHPlao4vK7CP+7C096+9c6oSALtMK82g8FkCg8i1EFvY5qB9538JrkQEGCWFp
         1r4na02bWZedOp3YkACr2AvPMAeWlq/VFYbPCem//MtqwgnVWmL3B4jTKTDd2Db18eie
         sFU8cu/0swWN0yQELqLxwqpzhqnnZeiK8JnYXAlcY11tm+fQf/5HXyANHTfwmOq2JQYQ
         NJuw==
X-Gm-Message-State: AFqh2krOzHpjJU4f47OBE9v7cWNUnujw6hg/l/nDebRjZhKvB8usNiuQ
        vfrAH8jKutiU0n/GOHLeYXkGkApJELP+FNWszTFrpA==
X-Google-Smtp-Source: AMrXdXuh+GlKNmUch0ZRc8MzfWoNPBsM2ioYq3g+Iac43u27XPKkKBuwD+SuGcMkFkoa2bTgXFhpxugGOlDXPHg9jcw=
X-Received: by 2002:a05:6122:d18:b0:3bc:c8fa:a0b6 with SMTP id
 az24-20020a0561220d1800b003bcc8faa0b6mr5661822vkb.10.1672929058361; Thu, 05
 Jan 2023 06:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20230105124100.185542-1-brgl@bgdev.pl> <Y7bWCm/hpK4pbI6W@sirena.org.uk>
In-Reply-To: <Y7bWCm/hpK4pbI6W@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Jan 2023 15:30:47 +0100
Message-ID: <CAMRc=MdwdKKEx0DZ6xJvYRu3qbvUPD-J1RbQ6b0uMkP_JU=5bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: spidev: fix a race condition when accessing spidev->spi
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jan 5, 2023 at 2:52 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 05, 2023 at 01:40:59PM +0100, Bartosz Golaszewski wrote:
>
> > can replace the spinlock with a sleeping lock. Using an RW semaphore
> > allows the syscalls to run concurrently unless protected otherwise. We
>
> I'm not sure this is important or useful, there's not a lot that can
> practically happen concurrently when we get to actually interacting with
> the device and it's making the code a bit less clear.

You suggest to just use a mutex instead?

Bart
