Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3310D2CCAC5
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgLBX4R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 18:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgLBX4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Dec 2020 18:56:17 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D74C0613D6
        for <linux-spi@vger.kernel.org>; Wed,  2 Dec 2020 15:55:37 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so707367ejj.7
        for <linux-spi@vger.kernel.org>; Wed, 02 Dec 2020 15:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tTqDFIETtXY0Lt59TIQii5AHbzttQkXZ7nkEQUlJWNU=;
        b=pwEPADFX4h1Drdp70LImtWMwWQeiaHLC20Opeh3X9ELIJBq6i57nrAMvDo65dTwneh
         RBDAhzSBu6iZkkYUpejtYHIqG0tw1Be9NX0CMcs2ozAYm68iMBvZA1W01f85b8j9wTDP
         yORgbhN8GuZJyx0SPvYma8au0HWXURT+ON5Gru7syKzXLwE81eifdsEPfIr2QEX3coFR
         OGLzD4duCQFnIL+04Xh8ZlbzYL/VXAlE5bX1NinniOhyATNm31DX7YZ5usUKR+rueygb
         h/y5kuv7zyItH37xM8nJ3EbDJZn02ahCpMvfUdFHLTKNhFjlYw9QEZ9hFjEzu1ph+y4l
         GlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTqDFIETtXY0Lt59TIQii5AHbzttQkXZ7nkEQUlJWNU=;
        b=F+5qhtFI9XcQBD8HAwe1IJL8oQ9YdyWbviRh7+ON+RvKim3XOvVrxvV2T5M8pKNqAS
         Q0RWE7x40a44xlui4dOEO39VOpcSr+9XDgqtej/RZOxlhuBO+aL5hleCIt3dU/bL1G0e
         fTRMUKg5birjpJCvlMI54ErWU8CxIDjmiubL8LMqn8g6X5BuhvnJeKgK+/bZdkQVRq8p
         tadmN99rL/+f3174BOw1d+fKh8TFaF8uyBcpnhG1DTCVebR4iuSg5LWIRC9SOtVvMVcO
         oIIyWB5xIOSPBzeqpP0gTygq6PHs8sWZ+o50w1hh3SgpZSUgu+eazrmC4NhJDeiaGimx
         d2GQ==
X-Gm-Message-State: AOAM531ItiRDgMrCaufFXscbHCJvdSxjEfN5ruqxfGmVmpMDUEQuqo13
        l35GfjDqGpR6wMKDkGYEkUE=
X-Google-Smtp-Source: ABdhPJx8bjdeI+UYOdF9gs89DDWzF0NMTMqq+2RXXbp0oVroUOJqULycX2DmjK/t6sJYYvjoKAAMxg==
X-Received: by 2002:a17:906:12d3:: with SMTP id l19mr207063ejb.65.1606953335989;
        Wed, 02 Dec 2020 15:55:35 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id j27sm111188ejo.61.2020.12.02.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:55:35 -0800 (PST)
Date:   Thu, 3 Dec 2020 01:55:34 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxim Kochetkov <fido_max@inbox.ru>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of
 num_chipselect to set SPI_MCR
Message-ID: <20201202235534.ksbpj6wfp7vkkwm2@skbuf>
References: <20201201085916.63543-1-fido_max@inbox.ru>
 <160683107678.35139.1439064414776102118.b4-ty@kernel.org>
 <e19002f8-a8a8-6201-6680-ef0b586c6367@inbox.ru>
 <20201202142220.GE5560@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202142220.GE5560@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 02, 2020 at 02:22:20PM +0000, Mark Brown wrote:
> On Wed, Dec 02, 2020 at 05:20:00PM +0300, Maxim Kochetkov wrote:
>
> > Should I resend it?
>
> If the patch isn't actually applied then yes.

Do you frequently send out emails that you've applied a patch and then
not apply it?
