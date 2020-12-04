Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABA2CE4B2
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 02:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgLDBGj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 20:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLDBGj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 20:06:39 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8098C061A4F;
        Thu,  3 Dec 2020 17:05:58 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so6289918ejj.7;
        Thu, 03 Dec 2020 17:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zawDXfV2e+DrFT4rJ/w7y+LtGY3DyFHn3h84rx+qbno=;
        b=h1UiqMsbeNmUH1fPKuAQBtgCPE5vLxSFhl2ie/rxpmpTQi5yU6MJoDGGMTRJ1hpwAe
         TkUP8X7hKp+/QqrL81ZnwIxhRLW1tEmejgoTKkh1UmxRHFFeg2oq6HIfG3v7ukjddbTY
         W8KpIRk2zCt5ZFQYl0QO5CAJmKnLTDcniOf5dmpDqy/lGN9UZx/oh6hrt3RKy0vNhKan
         lJWmNkNgQIu4ysLD38fe3hNlG95Siis3k2HUI1qeRiLxAWCRnjE7NupQFS8cH3dqSF7z
         oIEtG/DsKKvHKfCa6N91vb/avmOozcxOcDVx89FQw+0MnRuevnQynSDR+YXJx1YoHrBE
         we+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zawDXfV2e+DrFT4rJ/w7y+LtGY3DyFHn3h84rx+qbno=;
        b=eWMVjqPfifHSEyp0Ag0oI8n9VJmNQ4FccuHHZt5Rc7oxb1inXsDBAXXunC/c7kQUxl
         Dj+n273u0FdZAMptazVy87IZ+1CGbjzrXC5GlDOS5Q/GSh5+PUUi2yvPJjrd/NF7fbf4
         Lh07iMrsaI8r255+sKkPzD6LIXN9b+DXGuh1/mnYBsNr+Xs6emOuM+c0aRJLp7BLHFJM
         4HVX5Ce0UhXxukAmlWuE3T43RX8JI3STjDLY4MhICZkv52vum7TUG72eYfvlFSZ3tt2z
         6uXBFShUakWBFSX51f+lvIzlqdBmAVDjdsdc4U7j//3MDnz7e9XVq3uYdrwXxPYzIXLs
         iH6w==
X-Gm-Message-State: AOAM5320m9C79tiEeAl1517CqLIbVkV2u6P4qNs1sxMqxM8yylryewxD
        1up82L/72L2KmywN5iPQ1DI=
X-Google-Smtp-Source: ABdhPJzfK8WlH2XeJMJhDdXMnMKcAMMY8492cn/wQmNh1GHt5/vyf4kCdXdXnmBDGnRp6n47B8jiBQ==
X-Received: by 2002:a17:906:2602:: with SMTP id h2mr4855475ejc.358.1607043957416;
        Thu, 03 Dec 2020 17:05:57 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id d22sm1990133eja.72.2020.12.03.17.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 17:05:56 -0800 (PST)
Date:   Fri, 4 Dec 2020 03:05:55 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Kochetkov <fido_max@inbox.ru>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add GPIO chip select support
Message-ID: <20201204010555.oyipx77djdkm6xkz@skbuf>
References: <CALHCpMgQPDqV1tB6v0sA0imwfZGkoG_j84NZCehOT1pf8MTuCA@mail.gmail.com>
 <20201203175024.hzivclydoxp6txir@skbuf>
 <CALHCpMgmdfScVhWKhhtisZ=-rf0wS8CujDoVWBJ8qkL_OXGu1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALHCpMgmdfScVhWKhhtisZ=-rf0wS8CujDoVWBJ8qkL_OXGu1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 03, 2020 at 09:50:04PM +0300, Maksim Kiselev wrote:
> In any case, I would like to add functionality for using GPIO as CS.
> Because I have a board which actually uses this.

I have absolutely nothing to object to that.
But the patches should still be as clean as possible, though.
