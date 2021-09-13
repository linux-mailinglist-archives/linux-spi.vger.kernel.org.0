Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A43409F45
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 23:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbhIMVjR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244952AbhIMVjQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Sep 2021 17:39:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8063FC061574;
        Mon, 13 Sep 2021 14:37:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y132so7647339wmc.1;
        Mon, 13 Sep 2021 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yQp1Gbe1UktRtB73V3ScEPh4NqaNRN96L2ImT/TWPwg=;
        b=RUVn7B51GfebJBOz+cNbgXDIlRLlQJxQo1PLjK1GLy8949cUa20hVTKnkotbROfwr8
         /8kZvFXgKhHQSChMr7WYJMPSx2gnOK9WbQ+ATKx9+2Sv1+s9e56EDBqFDNkyMe7JMT9I
         jr4ATUKkKCkQi3J+PqoG93dBBKF1qTblDDjFyPthFBLfab9FUC+5wxhQfTcccvC3SOwG
         Gm2kJgGOv5xEJdwqfy+wdv24XRydBVhQOhH5+CvRuANCyQIYblKCG3RN8rezM1RNUh87
         jILf2NtXP8gNKLQsaW2jxL0nhj1Qft1e7OZwkBckA9xc6VL3vA3R3mffFwQUaVJsjgjk
         4Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yQp1Gbe1UktRtB73V3ScEPh4NqaNRN96L2ImT/TWPwg=;
        b=isXxC7JrWUHwijhmF7kgfbC4XvKHGvk0goErHcudZgCndCsZ9y3lIE8WhQ56SzUMiu
         HAvyAenac1zmV1I8TWXuUi0cp+HPH+QcXUNCIE5TDozcgUdodYDjoj95Sf+twII5IQYb
         DbrZcfqoaIqOzI+DpzOftTC3lQoE9li7GGRkIDtpC7RUS0bra+xSMGLvw0hXqo99mQx8
         nOvuE9rYka+Y2TC4zgVmRFBXZDslKRLQMfcQNavvoMaa7Nx+dCeH4p1p2y+f6xmz1BqR
         N+oMV5CKQhamzH+vxJvrDCYtt/ZfEkjF0tv3O5kj72S1k0BDu/VUzJTeWgXETyiaVi5q
         ZBbg==
X-Gm-Message-State: AOAM533vzcCgfGtvNJnervFwTb+44kxwPQbk0rR0jlE0TMTf+czgWCoe
        vpJdpOmBSROEQ3jmQRJ/3go=
X-Google-Smtp-Source: ABdhPJzKJ5KT27zNtWAOhvOyQnlUNhDqbQ/ahc8hS2iLVqbdtVX2pB/lIg86RZExqknPe97Xsg7FDg==
X-Received: by 2002:a05:600c:1910:: with SMTP id j16mr11766677wmq.11.1631569078193;
        Mon, 13 Sep 2021 14:37:58 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id c14sm8677869wrr.58.2021.09.13.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 14:37:57 -0700 (PDT)
Message-ID: <ffc1501d640706d4d69a78a7dfc6e498d3ebed66.camel@gmail.com>
Subject: Re: [PATCH v2 2/8] spi: spi-ep93xx: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 13 Sep 2021 23:37:57 +0200
In-Reply-To: <b8ddca2452bddaa89875a66e658c882f4d0641ae.camel@gmail.com>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-3-nikita.shubin@maquefel.me>
         <20210726165105.GI4670@sirena.org.uk>
         <b8ddca2452bddaa89875a66e658c882f4d0641ae.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2021-09-13 at 23:36 +0200, Alexander Sverdlin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > 
> > > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > > to Common Clock Framework, otherwise the following is visible:
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> 
> would you take the patch to a tree of yours, please?

Please ignore this request, I've mixed up the patches, sorry!

-- 
Alexander Sverdlin.


