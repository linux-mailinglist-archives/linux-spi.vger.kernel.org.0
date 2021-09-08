Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD940348C
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbhIHGxy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 02:53:54 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50892 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237239AbhIHGxx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 02:53:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dheO030393;
        Tue, 7 Sep 2021 23:52:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=oi/yD+HLw/j3H1WqV1hw04JNxfLVmG8nI980IjJJUSc=;
 b=WNbPhrJr4czkCknu/8hfciV9fEL3I9jzZiVK3kOn3twogxN6LV3k3ceUcwcWydq9LSG4
 s/SSz9VkBFjk7oAHZPlM/ZK8eTdd1GwBm2L8nqv3E9PJZIBMX0yeU+LMzWzyVvVHO4bd
 jlfcIaw3qbua+Uu3LcrGWzx+qAKyM5ngx8KkjBivpLqXvn2Xx13gAcS2XGQioNCWSOKq
 uSRbkhtvS3AMu407pF89IKuzWR4UNzaBmfLIi2WwLOSrzKx3QNKnjX8X1ulyMoeZesD/
 6Od4Ufx0vMCAVTk/WMv7uzVVffLR6fc6s3Q//saObf2WRWgcFmmz8bLk2Z2W5GOS8IWU 2g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5a1uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 23:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjkNTUGyxkPKY/o7WeS6NL645r3ztFLjLN1SR5pxXaGj635RAn7ElM5qT+bc8krl5QoMY0V3IgxqbjRouRuO6/lFv+Xv1uNKyWCZkAqcaHgFBMl1aGRX8+iEiv01Y4KqPa4PX1M2GrbAbdzAj44mujhYq4AXVjKxpMSSUemR8gf61CFqmwGTLlrLgbbUsCEQIDwWjMz+N88cDD6rITKWeNV8vKKjNnkoJ5NGGQAG4mahLU9va8ibYs6oBB+dTcztvw6eBVpBVmeVjw68y4RHiAw0ATD6DmrDK/Lxo6ADyzQEMK8r52zzajd2M/g74ztDCjFjwrwYQP4/GExr0VTjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oi/yD+HLw/j3H1WqV1hw04JNxfLVmG8nI980IjJJUSc=;
 b=KcN45KIdvE1SiJL/lWi6/zwBD9zbTrvN/ftDdCcQNyfHM2IL9u96Vs9y14vuRRzaLAo9WYpEqUkfLTMZvkkfeT6eUYXMhieFdzpqjym+y/wqn6XOuoFoXlhEBSdPb0rVhbwel7wO3Dut+slSRCZ3gnXsP+6Gnh8tBZYUnmpXvdwRhsOAW1Y+X4MY3O10uXAZbNhm/TeSiguLq+xra/MsDmii50hoR/DsYnXgzyKkuAfDOtl/L1GSZe1CtyIhOy0GwJENhIUQfDREyKBOPx7JTvMUWfLxqCLtdWkJcXCj0AuwqYPT5R/uLY0LZmiO1cQW5YiZwVh9LDC2bLgYEhpjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi/yD+HLw/j3H1WqV1hw04JNxfLVmG8nI980IjJJUSc=;
 b=myGNZdQXyT1G7selz6ZHzUMqYIzHPf/QwbWqRSLdeutrsO6EwoO7xRMPDPWld3b9hM3N79LknpMpU94mPMMBfHIUp5Mz1PQ2JI4fipR880HPYoyi7bnjQdqNya3oXpgBWi6belf6jEuCBwFT/BHdeYNMZE6c2DElZu6DDaCKzdI=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB2823.namprd07.prod.outlook.com (2603:10b6:903:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 8 Sep
 2021 06:52:38 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 06:52:38 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: RE: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Thread-Topic: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Thread-Index: AQHXny4YIjHh85hURU26SR02kFfey6uSoYYAgAcZ4ZA=
Date:   Wed, 8 Sep 2021 06:52:37 +0000
Message-ID: <CY4PR07MB2757DF7EFD862D67FBF648CBC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499829-20059-1-git-send-email-pthombar@cadence.com>
 <20210903181722.ukarfanyew2b7yoz@ti.com>
In-Reply-To: <20210903181722.ukarfanyew2b7yoz@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01NzYzZTBiMC0xMDcxLTExZWMtODYzZS0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcNTc2M2UwYjItMTA3MS0xMWVjLTg2M2UtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI5MzkiIHQ9IjEzMjc1NTU3NTUzNTI0NDY5NSIgaD0iS3Qwa3VWOXE0SSticnQ4N25oWDYvWkpwenZBPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1eb137e-2ab4-430a-8932-08d972953ef4
x-ms-traffictypediagnostic: CY4PR07MB2823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB282320E88ED7320C8DB0A1CEC1D49@CY4PR07MB2823.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJhqitI0C+nRyj7oMyQJxt+WvpHWX8jsEVczNKaoPZUNh7QxdqIVmFBuQH2sSVSpEr9qo/Ulsj/xbDmcQAZ4HZ5xwBcHbryvdDOE7DA1zXQBpoDpjsS8spUgsWasbiN27+WPHWHmlSjx33Ym6lrSRcOiUh/wQg34pTZyrLUElm1Gyi1N513ADG5Ljk9V3OjCQmqBjCMbN5NKFnJtsoNbozwbFICaT0nm5dz20tmHzn8BuMs9mdwPsBztSP2HwxytMHsJhjLnkDccSg9A3Ax8JgC2pIWaXFW9RzBOo87cMJegDpTZc5cxD7axOMnFKEyF6y0RwVEL30amAFdnGvrz+2mA+bI69budgJhLLGAdUaynYMBbOyaF07EvlelBLXOMwKQ/t3tZXBkn+cm6r2xgEQ4tH504CltwSN8hDhdwbbxMQ/xLjC54Ai/hqQK3vThwTggFbojU2x4CBi+r2YMpvoTCDYNyD6cHp44THIwuWP/LbTuqOuHsw5iY6eCdCGcaiq67W+N1PGuTm/bgFigpPscVKau+P9zJrMewoShY4/CVqpSUtozbhQ82SPDQOUREPCA3EynSqk8NVtXta14QpcODvDyJaabi4VFyWdX+D31H8ztFSjqu1tOwM70FABRWwPsz/5Ua2bU54Nd141MJqzgW6bGQ7kqg4hT1efZ6fBSqnuKyuVrrQdahfeAz5hChCreNbGH9RP2poieJzpxcFNWry8brvDOk5J4KrnGndVKfAR83ibjVwvVUELbYYMFk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(36092001)(8936002)(55016002)(186003)(33656002)(6916009)(107886003)(4744005)(478600001)(26005)(54906003)(86362001)(8676002)(9686003)(52536014)(2906002)(316002)(66446008)(66476007)(76116006)(7696005)(6506007)(64756008)(66556008)(5660300002)(71200400001)(122000001)(38100700002)(38070700005)(4326008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZN+8tgTW+E8CuxIZ/tDN1LexrLNRuBkEhv3BdttD+lS0dG9D7LEM1UW83ev5?=
 =?us-ascii?Q?iIIZpyNNqCA/ClYIbzwG873va7e7AOJd+BvTi7Kb/vOXk38Ah2oLxPAozgVR?=
 =?us-ascii?Q?wfPD1xBMMNrKqoOabMtu1IcURf085v1qMsxWOv/fcqDevf9t9pyqRnTQPwP4?=
 =?us-ascii?Q?w8qCfa0c4qZ2YltR9k3LGdsWBpig0p1kq6nzXFmcvuh5Ewa5I2ju3CTL80li?=
 =?us-ascii?Q?jewNAKTLhIxuaz/IvrU8Gcf6r4IVRP4maB/kbmomGD+8gxpwaw3tj06VgEer?=
 =?us-ascii?Q?0KZl7GnEMA4OhiuC+yS9vRsc1HgOhcLPAG2kp9jg0uI/4JfUhLUz6djy3ILr?=
 =?us-ascii?Q?zakOE1uETg+IxkOGcs03jLJNE1tUgNCbJ//qMMJOHLkJyrUYbYUUyAd6quw+?=
 =?us-ascii?Q?QOjTYQFq1UXVQscDfbej0mrbgmnVY5hxgZxPvONXL7M6pIgzmLuimfqaoamR?=
 =?us-ascii?Q?lW3JpxDHJK8RHI0Y7PvEDpgGfMOpLQ3eVkHUNm+Eyy77zS0pvHdS+RU7oXF6?=
 =?us-ascii?Q?hePKronlZ9/L2J1zG+AjqAf6IoOZw1eA+NP3gQ/SJY+ki6+F2eMR4GfxFEmx?=
 =?us-ascii?Q?n/YJg3EB0hGQOptoSYplDKEoLzfml9ReMH3ZlKkvFVFLNDL35+pPSBzKwkYP?=
 =?us-ascii?Q?sl2H4JXU6Zjota6ibn0Zs33oGTJECg7sDbmNkGr/seOTDRG2svfXiV+ToB60?=
 =?us-ascii?Q?lY7dqze1eOzdo1R8S6XxbirO9dKPj4cowxp6D6tmxxUZdLcNHsNO+3qI0VjL?=
 =?us-ascii?Q?DLZCILZjxGcG5yLYudDQnLW6ATXQ/HGHvX1r9xgNtFSbbjmj2NVwEwVU/61I?=
 =?us-ascii?Q?AHkvXuqjUNQt/N0+DOtWnb9/oHqfBFC6UV+BnnStX4pIYoWrmaFQ9Q47YTFq?=
 =?us-ascii?Q?k+shR4YkctnjmfFvXFFfHp+yxox2EkgRKQdP9tgdoKRL+wtXexKtTxbyLfFg?=
 =?us-ascii?Q?6r7TNwm2w3X2C3Pp1qRxtIgEAU2OlZvCQai3WiPx6S98VleKnhT33fgfELQM?=
 =?us-ascii?Q?xfsgvXjffYcQaRpmbO8x9/h76Bns8R66EGEotzFtG7uCFmeSTQd9s7t6/RMy?=
 =?us-ascii?Q?bWsa9U6M+hKpQelkYCjp96NI/xJaQVUt/xLVGlMg6AACSinrh3PNT316rLWf?=
 =?us-ascii?Q?sYyU3oOdtElWbvmItjyrEJB0nAWAZzR9oIszQoQBXF8bhN0p9Bj9lBY/kGDq?=
 =?us-ascii?Q?dT5fenJYvV+QO3ZU8aJDmopDOuje720wf6dxWSXxnpsunPI15cdkkOUktA86?=
 =?us-ascii?Q?HNTktIYf6m+z6F8+/nPAxhACMy1NhPzSZYAcpABeJU727nDu0GNzoYd1xwGO?=
 =?us-ascii?Q?qJyEj5Go9ILZI8XWgJGgfKrO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eb137e-2ab4-430a-8932-08d972953ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 06:52:38.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvl0PqXPgWBqJr/hL8L+KYiVr90HRGxCPVZIm+D5zZxR0EWei44+TV5gxSn2GwqUg7wev+TcaKWYwD2NWp1CJwzGVNVjmUkVcwi1AtVppwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2823
X-Proofpoint-ORIG-GUID: 6q7yhjV-JC73O7ssijszxJ95ZSikP-Tq
X-Proofpoint-GUID: 6q7yhjV-JC73O7ssijszxJ95ZSikP-Tq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=612 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080043
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>This needs to be a "subclass" of the spi-controller.yaml binding.
>
>allOf:
>  - $ref: spi-controller.yaml#

Isn't stating that validation need against spi-controller.yaml as well as
this schema sufficient ? Can you please point an example how to make
controller binding a "subclass" of spi-controller.yaml binding ?

>Node name should be flash@0.

I think spi-controller.yaml uses wildcard for the name of a device node,
so anything in string@hexvalue: should work.

>> +            compatible =3D "spi-nor", "micron,mt35xu512";
>
>These compatibles are arbitrary and undocumented. You probably just need
>"jedec,spi-nor". If you need anything else, you need to justify why.

Although just "spi-nor" also works, I agree to use "jedec, spi-nor" and dro=
p
device name.

Regards,
Parshuram Thombare
