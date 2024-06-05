Return-Path: <linux-spi+bounces-3228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C7E8FC215
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 05:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9014C28487D
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 03:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8593201;
	Wed,  5 Jun 2024 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="j59FnRBL"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2107.outbound.protection.outlook.com [40.107.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479C1C27;
	Wed,  5 Jun 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556697; cv=fail; b=IGyCWyUz3nFyqkF7iPQKeVkNyLdqAsMUaYF6zntBATZwXOTCIuti8pnE+GLuOnyInT6ilH0Rq+2XuUvnICknOc6y3YW0MbnSWhnyF3/XojnhcPk0RYgd9Q8VdK7FCimBo0qW1FwST0mg7l69kIGZqgHJZkoPWiHqBAtXiCQXDxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556697; c=relaxed/simple;
	bh=nlKpi/7AZmAMwoXEtwI35129XRkppaz/g4hGcbQl+f4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=K9cfiBDliSiJfhxv1LhV27fLhpDTYsDrsztP9FGr19ozC67he5uoT3wppCSMIuGDCKODYP2yM7LeI8JAGy/wA4NVvLm2eNIRNOAAHvh79jLPBbpcEOkWOBEepGB/v3lx0SsqQxVpOpu/ufPtY6pz4tjtowaanxBeUnNDZBvWoQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=j59FnRBL; arc=fail smtp.client-ip=40.107.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWLqSzr09DyJCw4UJK11KAqsd07IkcEl46LqIYIuDnmAy7XEuxYhbL0FZ/LgJVMDU1zTeF0v84Tz9qgoF54gEI+rg/cUwXKkLhZCi5mzZY1/WiR2gc3F4sdKgP3Qk2ZUrn/DAb5NCYngotFlub6eOd992F5w2g+v/yOH+f86dZUkedhOLvjEoVells3ElFg1sTFqPcgb+G9GH8J0cc/bYiZO8fkrkn+WFZU2Wjx18NC6PFO7HofYqKPmaUXplhKeWuC7MLDKYjAVh6GpZ6T08v7ehjaXT3RzUJkbfVB47nxqtielNaYE+i3IkJrguPUW0aaXYZxZ12KZksx6LQRSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K05MMavLbPElfgRjF3egIEohqEerzL6eaO3Sklr3sz4=;
 b=YbqdEx+pnOyOGERg4WpsnXMY6hU8cNWYhHwP1AFYIZ7Dw92599TNe2vD5IrkC28Xt2EnJVp7LeHBNrIS5nX9KOJdn2kSIjqpHPsO1Cbe10h55dmxYjZEd/YNFvUSSS/1KUO4XYugsw27UGVacSDzPxnX4q2scZ4Amo3ziLWfnJ+wcxg/sxl8bTcQk7Nj/Rp3RACVAvPWx+Ps5oorC+wpJBldaoada5ih6N2nJluNQiDJDS5hXWLWEcsqjMPu894Jce21dxzsEXi1Nzu1ujW7Kdtj2p0d9BBeFMirZbOuywwnLs5Q0K6fQLfWtBCrAdTMshxujIixLJOdfEYy1xJOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K05MMavLbPElfgRjF3egIEohqEerzL6eaO3Sklr3sz4=;
 b=j59FnRBLcfsH+sdyZhTVrQ0wOrsDZkHEyFSkM5pVXKDEjG00C+nNarsP0DlhDk+q+Lw0Ga7eZHP8NV8h+x1Nlxb9RVbJbb476+9UhqQxjAOmf8/cD9Ef54qw5vT/rjF0m2ZQoxe52DGU8lgQDA1uewDLABngUi2Bc652jNG8psQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by DM6PR10MB4315.namprd10.prod.outlook.com (2603:10b6:5:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 03:04:53 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 03:04:52 +0000
Date: Tue, 4 Jun 2024 22:04:49 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: omap2-mcspi multi mode
Message-ID: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:160::14) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|DM6PR10MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: c97e5aa8-a78d-4eae-632f-08dc850c44f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3jHbX7DkOVdZlDY/UUIf27q2jXXEUvfcNappXPDnulJ9ZVNNpetptyJ9rFVY?=
 =?us-ascii?Q?+8lrCPteDMUQa0kHikx9ylVyTnvHzGcBGkWSf1pQ4zFP30QMvgAr/ugle1+U?=
 =?us-ascii?Q?0vdBNdIRfK9WHh155MgchjJEDeSlHlmCTRvBFgdGQPBfZlHjZJzeua7vtBkW?=
 =?us-ascii?Q?mC8AgAiA1FH72bOVwd8cykHAo6eugRZpJni3rMXup/d5XXt8Ta0aiqv3a7Me?=
 =?us-ascii?Q?CdIfxDxzIRUc3heRZSUiiGGCpfFMRIVQ+mIz7MfTSICQZRweo79xnxuPw0A5?=
 =?us-ascii?Q?oAmH0dsKWuZLj0LT+7cKa27FoiOhdBgE+nz2PXLqnHEbEiLMG47iPPVyMGh9?=
 =?us-ascii?Q?N2Sjr3GuAb/qAGLzKwwmO70zyLvdrIzPYMH97MEjQZKwndM1S+KrC30SeQU1?=
 =?us-ascii?Q?aSlhxFIXpHYKJ25+Cf4MjSj5fUmdofL7PjfEuvBuCyHlibllEV9FdTOxVh0V?=
 =?us-ascii?Q?+5JtwpNOwaWV/OQ9p5DaZDITjUGNP7TVgVp+GAnPwB9tEYwc/+Qm81twkjCa?=
 =?us-ascii?Q?Bq+6QlLN8HliIUfnk5RqFMtSJHWCVRkHGmcuFWb3nx6LthMS9MP9lFdJbqkV?=
 =?us-ascii?Q?9T9D1+69+Li8BVGB6Jq0lRduWsj1j7lIWHebZQgn8PiLus51arfPDzQco9CL?=
 =?us-ascii?Q?hRn6I+799fseJB+292vGW8qLtt6DEpCTwudYduTm4CsGPlNIMMUo24E/cr/5?=
 =?us-ascii?Q?8FmgaIBJWr17jkCj7Djw1XCxyxwHVbbtXcLGm7IjhCvZROWASRI9pzTDB6Vt?=
 =?us-ascii?Q?NfIJfZc3Ah9VpP1I4pdUJwSM72lllXQU0FCIPz+iLYI4MkT7CpN6TWo35arv?=
 =?us-ascii?Q?iSK3vhJ0X3WRRpL8Hu2bEOID8anUnnSbfHopNdCOwpW09JQ+Grxv8hxmEnV8?=
 =?us-ascii?Q?e+2bjOnirHePTPTi1LgoFah9oNOK8k8UFigBPp+DUwY3PAroZKKJ/uCvaASm?=
 =?us-ascii?Q?saPJJxPgqkmvk9AGhtCxYcJNdXE7dLRzkragfxZFvFVs3Bo6NzFS/S1Xr9/u?=
 =?us-ascii?Q?Tp1T2hN0qDm6ppXOSCXIHXpubhMkYU42zq2NbFlIdv4+D0/3niZwU+xbIAiM?=
 =?us-ascii?Q?6x7hVBGybRRaASk6vHahZG9sH2c8kXrPDxtEHfNa/LuAi2RlG80F0IBv84O8?=
 =?us-ascii?Q?tM7BAQyQo9BHmYoSgy3mr30kwbPkS2xgyTvIRifUqPfWjYP4fzmxqhmp7Hfr?=
 =?us-ascii?Q?y9cI3gdJ6RJWeg81R1AGtDungPxFd6/ug4wVlHo82YlW0dsxxuK1imTPvQ2F?=
 =?us-ascii?Q?5wLgr3qf+qTQlxAIfGJ2LJNpBn2jejCv3KdV3RWc/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pp3805vJxllX3SyQnshFDrC4ytRPcaeNTVcrl2A9LluOm0Z5snZ7ZpDsXuot?=
 =?us-ascii?Q?fIHWuv/YrURkGWJItYDhAta9Zk4UViCd2R3K4boruFbA3LOnGjPECt5USAuY?=
 =?us-ascii?Q?zkATe/Ov4zPvRp3xnlzEai4NkSikWWgSMHaWutageFl0YgQrraseHmDCUgUF?=
 =?us-ascii?Q?/L+y/AkqD8+s+Lyadv4zM9P5ubTPpmaMM41JaeE1qpFuQylGKtWeoXjFQqsQ?=
 =?us-ascii?Q?vdcOPmu9u92/jNyayIFrpr43zKpWQb88MEfCvgkFTu/7tNmghlF3uf/OkN1X?=
 =?us-ascii?Q?/couGcUyGzsTrW7FsEqWIinISTJJIea2m33Ve50rqYgxWRld4X1SorPFKFDl?=
 =?us-ascii?Q?aghxY7+1qn7Iu00K0fyvTr6XK0/Sy4GpAO1H8VXDfw8rjMsqe09n6hyhPi9r?=
 =?us-ascii?Q?qRbj4oUNKq+iCzvR5+hznTs6/axaKu+LkCUkvxTe0HgjPAHaJBjBq4ECiULN?=
 =?us-ascii?Q?3r+kSO9k6x+ePuXo9im+W7KJXwCsJhgcZDpgc5aR6adgRoVCxCGFN/39nBlK?=
 =?us-ascii?Q?ULBQbEwqiuTBktMMbPHhJt4lqsvz30zQyRSbtKS8TDLa/4l9b92YuYlsfSdv?=
 =?us-ascii?Q?M/xdOGTiKPzF2N4MJJBFRY/I3rlMwYoTrpEy0DnnHjpwnmXizkqQZbCFrMUh?=
 =?us-ascii?Q?IoMUW9mvcUzLxCIAt8TkTXznbuXgwQokLyyfpPGGYir4iUhJZHYLU8ub74KI?=
 =?us-ascii?Q?htlT0nYyHG49ATeG7fsgulbLJ7b+1M3dycTtvix33KekifFygcfV4NDxSQwt?=
 =?us-ascii?Q?1cZ10rnzl1yP8LlZsS3zGZBxLocJqUZ9ovstsN9V5WiKpgal3hiNGeKLf0nn?=
 =?us-ascii?Q?ziZ2rjQVMuPoqe5pZEmR7E6UCLOJM3FlSBo3N37dcO7KVPywvJDNP5puGOOw?=
 =?us-ascii?Q?JTKwJ3oA1Y5vtNrtvq71cIyzsoSokdeTwLJF3y7CSm3pR3y+G+AkHKY2wuIB?=
 =?us-ascii?Q?O9LYujZ9JUP27ToYZS2iq8BU0uXK9GHbEWDlw2bPoFWkzxWKBQ9k2zLd97eu?=
 =?us-ascii?Q?HGbeUjtiHlaFwVDIBX+giHS2MWAXUJJI4InPI13zYN1c6weerHPw81glZdK8?=
 =?us-ascii?Q?elRTIv9U4bRgDE7GACChKlRppJW+jrbJUpvMCTlsW5G7OMoSYCx6zdAtFmxB?=
 =?us-ascii?Q?pLOx5gbMx0p4fDQCU0umywEhGTvsuSm0aDdaKGQkBXDCe/3HgE0KtlLbXGJ+?=
 =?us-ascii?Q?G+HF7HEPUmv/FBZWA38VyZogueZaJwPLatSh0ujIqWi3q/G4w7anCbAfTZV5?=
 =?us-ascii?Q?qLwBwUkkvhBr792a1Dypr8N2ECr9sIDAqWE4THCBJmBF+LNdVXuZHOlCL/Hi?=
 =?us-ascii?Q?P0hqSinVL/6srqXmxGgjXtbgR3D5M5rTQZ+VC+/Wt1536qWGSIwYq9AjJRwD?=
 =?us-ascii?Q?0j7JHPXUGJDusPHN3iezuyNy82Q+K1AkN+nuAkBrnappBW6/nn1NneRSTKd4?=
 =?us-ascii?Q?Qp7rVECeVkcRl/8ujb+5Q50nOP0Qfni8NDJ6gZ/bbZ3/PN0B20hMPj38VEVq?=
 =?us-ascii?Q?UUJWI3gXECQo35zbZvLMZ4Qlr2zmk/r3cNmjRa70DimBSVEnW235mNURSVer?=
 =?us-ascii?Q?opsmYy4nSmLzAmdWOo7ndCz1R6ZBP80o65YI4Mh8jHSBG7aWY90Ue//RDTge?=
 =?us-ascii?Q?1DD/DRAlJOY2M4MCTH03dW4=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97e5aa8-a78d-4eae-632f-08dc850c44f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 03:04:52.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBkzlmlQwrXXPsbEirTwqWtTyjEJyvYi817wovAR2Cs4riCzw40888ztHd+9oY684wBHIitAODD3xOALV3uECDEUhHu6sMyn352QT5bBiRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4315

Hi Louis,

I found that commit e64d3b6fc9a3 ("spi: omap2-mcpsi: Enable MULTI-mode
in more situations") caused a regression in the ocelot_mfd driver. It
essentially causes the boot to hang during probe of the SPI device.

The following patch restores functionality. I can hook up a logic
analyzer tomorrow to get some more info, but I wanted to see if you had
any ideas.

--- a/drivers/mfd/ocelot-spi.c
+++ b/drivers/mfd/ocelot-spi.c
@@ -225,6 +228,8 @@ static int ocelot_spi_probe(struct spi_device *spi)
        }

        spi->bits_per_word = 8;
+       spi->word_delay.value = 1;
+       spi->word_delay.unit = SPI_DELAY_UNIT_NSECS;

        err = spi_setup(spi);
        if (err)


Colin Foster


