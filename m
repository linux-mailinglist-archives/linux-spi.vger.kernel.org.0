Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3F2EF1B3
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 12:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAHL4d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 06:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHL4c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Jan 2021 06:56:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0CEC0612F5
        for <linux-spi@vger.kernel.org>; Fri,  8 Jan 2021 03:55:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq13so3517678pjb.3
        for <linux-spi@vger.kernel.org>; Fri, 08 Jan 2021 03:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzO3kRDPJR5SduIzJ6FmhhHpMA7Yf0Zp1ENuF+c77Fs=;
        b=ExYGMHEbWfTzLtCDV2MlAbpmQZ98EJWWJOgdz1XhSv7rad9+mRGO7XIUQcPlwLmhcf
         G96a1sWfnBO7Rwav6DbNsOv+AXkI+VITOnPrYiSgWgzyHTfqjgQVUZgSwRo4xzB8MwXv
         j9Yqm/+H0yQr4omQTO7nSmBVXvD7nkch+iNRpCic1/b4bmYK5+ds4As3X6ikbfgoWcwS
         1szOZHmpn0Wnm5yLoUozjWZAsna+yHWk3FjvTbCjP80f/4NbsNhDORtBa/1Q5CUCqKlP
         1kGNJFS7Mk6ApobG/0L+qJCj6mE1AkiICTQmFSKeUpl8FV8FETKsPQTGG0QWRPo/uKQu
         McWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzO3kRDPJR5SduIzJ6FmhhHpMA7Yf0Zp1ENuF+c77Fs=;
        b=FNtPibArIsFXcY2b0HOFlCYHqHIDLYdqkmbbN9pLDraoXOeFmK0dbhjdoQfkBRfhHf
         Qr+RPTh1FDWpl19MigsrLsBxy/s0PDyddsdYjOIu7pRaTVPtcvo1Hg37JaBo3tGV7sSU
         1BQ89fyCqH67EdCCQoIyw8ts+k141CJ45lS1Zx0NsMrTKmQequjy+e0V5ZmvBXpb0NOD
         NFycif5OpaiEtZXTp7hUpkjdofg2GIMpLgNmtxKWZvH//oI7agzjnsyKHDQr6ew5JB8Z
         KFHU9N++6zcc6lUGIzx7wnqaRplfqBDRc5qOGDdq6Y+LS3D3LOzz5QCht/61HxRYa3hc
         Mj1w==
X-Gm-Message-State: AOAM533PD76pj686EWq9Pp9EKDNLYX7b5DPiLTlAnUtqkQKblgLLa4MF
        543qmoeZfOkZLnQXyMlOpPQ=
X-Google-Smtp-Source: ABdhPJxZ2fWrmbbCZzEk8MEsCndHn4iEaFyik8LxsqQLYscn7jHxfTEKus1zWQ1L6wuWYfzVXZMLqQ==
X-Received: by 2002:a17:90a:df12:: with SMTP id gp18mr3336759pjb.43.1610106952007;
        Fri, 08 Jan 2021 03:55:52 -0800 (PST)
Received: from localhost.lan (p8006072-ipngn42301marunouchi.tokyo.ocn.ne.jp. [180.34.60.72])
        by smtp.gmail.com with ESMTPSA id 3sm10015300pgk.81.2021.01.08.03.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 03:55:51 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id EBA05900892;
        Fri,  8 Jan 2021 11:55:47 +0000 (GMT)
Date:   Fri, 8 Jan 2021 11:55:47 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to
 spidev
Message-ID: <20210108115547.01bfcac4@gmail.com>
In-Reply-To: <CAOMZO5DSw2Nz5e_0Qn0LcqT-uvvpbjEczUOs2qoEbgC+H8Ho5g@mail.gmail.com>
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
        <20210106130049.GC4752@sirena.org.uk>
        <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
        <20210106173759.GF4752@sirena.org.uk>
        <CAF78GY0xnKrOj5RhU2GHcQUTo2MLryrBj3+5dAMKoGzJn2okYw@mail.gmail.com>
        <20210107153546.GD4726@sirena.org.uk>
        <20210108011044.5780aa96@gmail.com>
        <CAOMZO5DSw2Nz5e_0Qn0LcqT-uvvpbjEczUOs2qoEbgC+H8Ho5g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Fabio,

On Thu, 7 Jan 2021 22:53:05 -0300, Fabio Estevam <festevam@gmail.com> wrote:
> There is a fix for this:
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-linus&id=6820e812dafb4258bc14692f686eec5bde6fba86

Indeed, and I missed it (I somehow thought there was only one commit
not pulled to Linus' master yet...).

I confirm the issue is fixed as of Linus'

commit f5e6c330254ae691f6d7befe61c786eb5056007e (linus/master)
Merge: a1a7b4f32433 6170d077bf92
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jan 7 12:21:32 2021 -0800

    Merge tag 'spi-fix-v5.11-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi

My apologies for the noise.

Regards,
-- 
Vincent Pelletier
