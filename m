Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACAD1541B
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2019 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEFTB7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 15:01:59 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:51609 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfEFTB6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 15:01:58 -0400
Received: by mail-it1-f169.google.com with SMTP id s3so9936018itk.1
        for <linux-spi@vger.kernel.org>; Mon, 06 May 2019 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNrYOFBuOphi+mBs3VSCY4wajSxNOE2btnBCevj2sfE=;
        b=Gb2RLpd6aGmJwcl4kHm/oOOG5vHh3j5g+c3TBma1DPOqZV5/SdUhfl3cAT4tvWLmb4
         x8tmlD9sW/6letOAiHU5HQc/aU05XhUcxYrEqxIcWAO5la+cds5aO2Llne8pqp+S5ora
         fnfAldz671WumOHU6a93KaLfzLI8MIqcpBE+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNrYOFBuOphi+mBs3VSCY4wajSxNOE2btnBCevj2sfE=;
        b=QjxTk0nRQv/sWn36CYxRin3IGfS1W7Rmt8ceIKCIFSpH7J39nQJNqeIlLwE/rCnrVf
         vplewprbucnE+eYoMTYPTLKol7OxNm5rAo0EfAOZ7NLkHcXecH+a7ZSjkavBxUEWDnl4
         4TB83+SEYvCtKPfGy0LkCq285aeQsf95Q074pjjxrUli+UQKBgJ0saEsPLx0DFLTyC1I
         +eERPABHoVgSGQWAJTPocZhAWjkah+1wLXZIPKGaIJjn0vbAfAXGRUctnuHVlGprrBhk
         nYQrU6T6sZLCKroQuZpMVNklCI6PNPOHpxaY1oNa7zyJbbPXi/yOIxxMYZuqvoyJGP4j
         S8sA==
X-Gm-Message-State: APjAAAWHL75xNef1gfSr0mi0zrUMKFJvajXQjFbzbUfzb6jl4vDnFioi
        h1cMglEr8TF8puwO3W9xKDuzIXr5Iemc+KW+fb7LTA==
X-Google-Smtp-Source: APXvYqyCAW0wcOcqCteadBtbfWvZ7DLENXXDxX7l2udWc6idAoHR9OZjxUNSthdWykaz/WYfBwhF+sEiexKhTJZhNq8=
X-Received: by 2002:a02:a394:: with SMTP id y20mr19808316jak.96.1557169318124;
 Mon, 06 May 2019 12:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk>
In-Reply-To: <20190506143301.GU14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 12:01:44 -0700
Message-ID: <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mark,
 gmail once again hates your emails. Your email ends up as spam, due to

    dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

but it has a DKIM signature for sirena.org.uk:

    DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
d=sirena.org.uk; ...

Hmm?

                Linus
