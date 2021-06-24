Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB46B3B3476
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhFXRM6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFXRM5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Jun 2021 13:12:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308EC061767
        for <linux-spi@vger.kernel.org>; Thu, 24 Jun 2021 10:10:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k11so9182407ioa.5
        for <linux-spi@vger.kernel.org>; Thu, 24 Jun 2021 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=UZ+/VjiF819MgRVYmSa/OMhqMfkC/yEgfnEQuJltW5yVR9WSPy4OU31f9FVJ2FvSZM
         q5F+9yb++Dkc/9f2j5uMXiDP10iYs2QJeyHJbIh0CjQ9mubfoLP4b/nWOrV6ZW3Y0eXx
         Jy3EtgkvOQal7eqm8FFNEkcEY13qCZsokx/A93zRMVaqk/dMYxyFbq0OV/gNErogDca6
         zPT9l6YFxKsGZIqqyUIuv8MoPN9VdmiB8HtDTUt7GkgKUVQn7xoLCjjzZ5QMsdLtTLKg
         DwnDQn9slOLJnh2RbiiCnsMK9kBFpYV81sT8yB8hW5xiTbPFyNtytN89dy+n6vqDxhHe
         dY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=mHAp2jNZD8jKVeKXJ7atm9td2HbKSDFM8iKX2SIcAcn6P+OA+eEOCRzSPxe1GdN3IB
         L+/fSp9m7J8oeg+MSuEilz3DNxYHw12Nrcs0/DJElB2tvaM/Fl1SZGzl+1HD29hMVXso
         grbrgngUyXUbTBTgO76nqCyADWg9ljN9sbR3W05684Velj0OH/N/T8XYICOmU3vhzcnS
         feV/3WGjSkdxYWtXcJswDD7aBitG8ESaUAnLZyDQd6pqOs2V18LcIb6wscRwA4YOnqBu
         HyScKNiSye5WB1nxIcc8cdfbjyYXDDzVs0h/W6Vqmw3sAf99YZCvBb9kn0KmJZCi/4dC
         wFMg==
X-Gm-Message-State: AOAM530swxO/HLzNT1s5+c90zVTRX6fuSR0GxO0DJaKYBKtGV5C/7lq4
        wprn+dB62hrQDrMvUXjgyKYQXST7S1ulKzYCak1S3rAG9Enkkw==
X-Google-Smtp-Source: ABdhPJwnWtBX/xPUpVgs9WxMlc29Wj7m9hM8FjTEewInglgRy/Qe1Vg94OFbXQ7c5AwqZ8QiyUoqP5WU0UQF9SwGiU8=
X-Received: by 2002:a6b:b554:: with SMTP id e81mr5011767iof.163.1624554636366;
 Thu, 24 Jun 2021 10:10:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:10:35
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:10:35 +0000
Message-ID: <CADB47+6Ju33YtZhH5aYWAvJsqgLWcrRuA17P=6NJCEjCyMFxOA@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
