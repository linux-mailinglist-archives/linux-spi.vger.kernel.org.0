Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE9157B1
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 04:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEGCet (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 22:34:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42875 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGCet (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 22:34:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so10600130lfc.9
        for <linux-spi@vger.kernel.org>; Mon, 06 May 2019 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtEkyVeK1FG141ZNbqUNDiDkDaGa5Egmv7z41Kin/Z4=;
        b=bMpsabR8hmahjs3RFGKw3QVCOwzsV9GbkOHIuC+Dib6ELB3W2v2LQnqamGXsCBN7zp
         k2yliPz5yx0OjC3SBTcyQKjEUZ+6CaNyC8hMRNBJWhX/dULq1WZ6c/SMO3NcID56id8n
         se1+GooMIUOS9ysKu0WWktm1ZEx0BepMEm5/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtEkyVeK1FG141ZNbqUNDiDkDaGa5Egmv7z41Kin/Z4=;
        b=hIf9921bZZLYebPKR4dhZ0mA6zm3l0aVjABaq4bfW0InCsjdHvq7mo14bh51tkl9Mh
         FeAJsbly3IcrHHwnQBvpU9Trsrm2Tzv/+B4NI9cody2+hf/noPXfYBiCEiBuYH9Jrczp
         fO9zy522DVjSnL3UTKe/qods9cCQDUOmHMy2k+2O9MOqzHqSP6fBBi0G0Z2tZatOsuRY
         HnAMSvI4UTP0PIfKiegmLnKf8nd28xA+WuGVUpdhyCweJ5WnWDWPEYQ/MqD0U4tL+XCB
         FthxF5yHRYRObxr9fSzESiYePXX89mxArzO1zsiYb8/8xmlisCw545ozRGgiWy/m/k1e
         jWdg==
X-Gm-Message-State: APjAAAX0g0zNz7VKTdnY69nx1NHpm3co4E9dCLWLHTksvDHaT5WyQRNy
        Itc5bTEuW7t3IbdMKRTp7IynvztmMN4=
X-Google-Smtp-Source: APXvYqy3HQyo8/iSlqg3/0sJ06MwXbfvXcHgMtrQc29M7UEmP33fqnmtbXxDFxGiF7Q1FBY88eH7hQ==
X-Received: by 2002:ac2:428f:: with SMTP id m15mr14712302lfh.40.1557196487344;
        Mon, 06 May 2019 19:34:47 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x6sm2871472lfn.74.2019.05.06.19.34.46
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 19:34:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id h126so10602048lfh.4
        for <linux-spi@vger.kernel.org>; Mon, 06 May 2019 19:34:46 -0700 (PDT)
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr1358836lfn.148.1557196486137;
 Mon, 06 May 2019 19:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk> <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
In-Reply-To: <20190507021853.GY14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 19:34:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
Message-ID: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 6, 2019 at 7:19 PM Mark Brown <broonie@kernel.org> wrote:
> >
> >     dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
>
> That looks like it's a fail on validation of the kernel.org bit of
> things which I have no control over and which purposely doesn't
> advertise DKIM stuff in the hope that people will actually be able to
> send mail from non-kernel.org mail servers.

Looking around, I think you're right, and it's probably not actually
the DKIM thing that causes problems.

Because yes, kernel.org dmarc will just say "ignore".

So I think it's just google that still doesn't like sirena.org.uk.
Iirc, that's happened before, no?

                   Linus
