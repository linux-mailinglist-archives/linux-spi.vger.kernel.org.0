Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872D8409F41
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 23:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245480AbhIMViH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbhIMVhu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Sep 2021 17:37:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC126C061574;
        Mon, 13 Sep 2021 14:36:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x6so16794684wrv.13;
        Mon, 13 Sep 2021 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jyAZOk2VQqsObFi6swF1vgFsTPCTM+9EQwLaIjqKTno=;
        b=MoYhAeu+T50EEcqHc5ggtsNZxS0ZzwaHPbRn/on8NVl4bkhSjoZHZdkJRsl7n7YXJp
         hfirO2i4QEje9H0gNmjvHtR7toEfenfS7gTi2TTU6slxZNY/UudryGa1lUTObCfjFfn3
         7g/ZpB+LMH4SJTiqT+f7oGo1NLh9gLcyOiqmw1Hm2xbkS7zmd1Am6yD6JGAjnT2cB0h7
         IhdSSud9Z+CLrvDpr17uJ4qS/ALJiE9z7pWAjMVbkQVK/BV8T7lMAxdxJpZrEpsfqU3O
         VStxW0mSx4WifsdRLM4QKt6opmO9mHU0YwNRmqfPZwVHln+vPCGp5qXFoA5/O/FP4PTb
         UB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jyAZOk2VQqsObFi6swF1vgFsTPCTM+9EQwLaIjqKTno=;
        b=IM3bTBtBc95rMNXT8LAt5yi5qI446ioBUE3Md1I44PDRi/RLiQGahvSGJKDT097i+4
         v5+YCxUv71M1Nxse6E5GP2/zfBYF1dNHianGgwoltSkTEx6L7w2oqRJ5H6BsAyD/a09r
         NVZJTckGfYDZaX//mqZQJBpYDGTtZ5bAgsG4l+FmIiCvSKJWEcueDjEQsuvtGwOe6uMP
         x7G26y+O7Tgf0zR8fvRzRkOqeYpAdhrPJBBSnoejxrTBKQCdWAqIF1CXhFS7jq0lkRBW
         IuaIWy/bl/6Fc2xbnlR5VmEx2zBsT655/dYZh0+OSEMGC+uRK7Rg84r/Jdbso6O4TLF2
         5+5g==
X-Gm-Message-State: AOAM531Il2GZChlj1HLDFgToSYlzvdGRZoPgBAkzzueZHTunqvMxnEVn
        3UPfUXNNz4zuq89bY+iINEE=
X-Google-Smtp-Source: ABdhPJyNMk5h72CxcYhX46rib8sUwLHeHMIPoqsl6dgkS1yOb9kRm0lAiVCQ5EsoNLu6ZIXK8Q8rIg==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr15369983wro.109.1631568992326;
        Mon, 13 Sep 2021 14:36:32 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id k18sm3936677wrh.68.2021.09.13.14.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 14:36:31 -0700 (PDT)
Message-ID: <b8ddca2452bddaa89875a66e658c882f4d0641ae.camel@gmail.com>
Subject: Re: [PATCH v2 2/8] spi: spi-ep93xx: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 13 Sep 2021 23:36:30 +0200
In-Reply-To: <20210726165105.GI4670@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-3-nikita.shubin@maquefel.me>
         <20210726165105.GI4670@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

On Mon, 2021-07-26 at 17:51 +0100, Mark Brown wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > 
> > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > to Common Clock Framework, otherwise the following is visible:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

would you take the patch to a tree of yours, please?

-- 
Alexander Sverdlin.


