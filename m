Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEDE377812
	for <lists+linux-spi@lfdr.de>; Sun,  9 May 2021 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhEIT1j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 9 May 2021 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEIT1j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 9 May 2021 15:27:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0AC061573;
        Sun,  9 May 2021 12:26:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l24-20020a7bc4580000b029014ac3b80020so9948206wmi.1;
        Sun, 09 May 2021 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r2dEu4hvQezgg+nEKJ+VJ/vBdC0xX4twJSBrlDmPz9g=;
        b=G/KL0GMi8jlxQvskJcAJpLMVgkkRInd/fz5i0z+p0mE+1pAMVNLchRxBNJuFtvEGqT
         S0/auBsfA+rb1D9KysOl+9o26ITBn10gu4jWCgHHGf7bNY4eKrKJWa6qp5Z8V2y5JMcc
         aGeu02f85d2ON87lBYZAhzKaWxKKeYn8N69nhGT+UFbqKJVmC/n3fM6Sl4rG2tkPU0EB
         nKMlYqqcwXUBGCvAI+4G99gOG4Fxax23KM/y6hyGYYjxavfix+2b6RTDd9W040MGi4TB
         DoE4YQqcO/Puqq7BSRpgqAmauieoEDpH6yw8PjGTecyMIORdKKhKyhWESufyet8gbpLh
         Ifqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r2dEu4hvQezgg+nEKJ+VJ/vBdC0xX4twJSBrlDmPz9g=;
        b=O7jkqrqlfywBDpU2Xb+aZvoq4H4mZNUJLJY+x5evXNdDh7fAAM0F2HzfT0cmCh3oHl
         jGFw8bfc7ZXbTDfpWL7iDLCt9RlEZ4tNSjiXP4d/U+FqHeOLyKzSZpbXVd0uAUUCiXZv
         VUgmC2ZQV9t1Ix8atclPJah3Ojkr5stTQcot7HycKvDbM04QAbQaG+SWDvRsQ+5BuSwQ
         kJp6MjHx/LQMVIJpUsUKqbBz2vxVHE6ZVOIww3wj6LfsdUMrAmQFSaAw5GjVKyiKrDUP
         qM+9B8Liuei0BhfgWRd9QJnWDaEiNg6NUbjcbOHO79pUQuVw+UZD4v1Mo7DMZgsDDjWn
         vsWw==
X-Gm-Message-State: AOAM533gOClG0p9UJs388Ox8gb2yiv7jpAmnpmR5+LTTJpEdo4r/6sxw
        G/UvBwgH3QjefT/Tkpp2854=
X-Google-Smtp-Source: ABdhPJy4dAUOVwJ7oBJqhKNx2n2E67kQzpf67S5Qs3BntkX8sTKk+BrfWnF00uYW3mHw28j0dG6zNA==
X-Received: by 2002:a1c:4c07:: with SMTP id z7mr22592916wmf.96.1620588394388;
        Sun, 09 May 2021 12:26:34 -0700 (PDT)
Received: from skbuf ([86.127.41.210])
        by smtp.gmail.com with ESMTPSA id d15sm19175233wrw.71.2021.05.09.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 12:26:33 -0700 (PDT)
Date:   Sun, 9 May 2021 22:26:32 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     broonie@kernel.org, maitysanchayan@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fix a resource leak in an error
 handling path
Message-ID: <20210509192632.2nzgwckpai34hgnr@skbuf>
References: <d51caaac747277a1099ba8dea07acd85435b857e.1620587472.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51caaac747277a1099ba8dea07acd85435b857e.1620587472.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, May 09, 2021 at 09:12:27PM +0200, Christophe JAILLET wrote:
> 'dspi_request_dma()' should be undone by a 'dspi_release_dma()' call in the
> error handling path of the probe function, as already done in the remove
> function
> 
> Fixes: 90ba37033cb9 ("spi: spi-fsl-dspi: Add DMA support for Vybrid")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Thanks!
